---
layout: post
title:  "Stop overloading JWTs with permission claims"
author: stephen
tags: [OAuth2, JWT, OpenID Connect, Authorization, Permissions, Roles, Identity]
image: 
  path: https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Truck_in_India_-_overloaded.jpg/1280px-Truck_in_India_-_overloaded.jpg
  thumbnail: https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Truck_in_India_-_overloaded.jpg/640px-Truck_in_India_-_overloaded.jpg
  caption: "Photo from [Wikimedia](https://commons.wikimedia.org/wiki/File:Truck_in_India_-_overloaded.jpg)"
featured: true
---

Here's why...

{% include toc %}

# TL;DR  

The authorization that OAuth2 provides is likely a subset of all the authorization you need. OAuth2 deals with what I call "**identity authorization**". I think that we've often misunderstood authorization by trying to make OAuth2 do more authorization than it's supposed to by customizing JWT access tokens (that should be about "identity") with application-specific role and permission claims that don't belong there.

# Authentication and authorizaion

You've probably heard it said that OpenID Connect (OIDC) is about _authentication_ while OAuth2 is about _authorization_.

* Authentication is about _who you are_
* Authorization is about _what you can do_

This is all true. However, it's not quite that simple.

# What kind of authorization does OAuth2 provide?

OAuth2 is about authorizing (or delegating authority to) applications to do things on a user's behalf without requiring them to hand over their credentials. In addition to this, OAuth2 "scopes" let the user decide to grant all or some of the scopes requested by the application. But, you can't simply trust a user! The application has its own rules about what the user can do that go beyond the scopes that the user granted the application. Application rules are not what OAuth2 should be used for and scopes have a more specific [purpose](https://auth0.com/blog/on-the-nature-of-oauth2-scopes/).

> The application has **its own rules** about what the user can do that go _beyond_ the scopes that the user granted the application

OIDC and OAuth2 are very related. You don't need OIDC for authentication. Facebook, Github and many others just customize OAuth2 for authentication in addition to authorization. What's special about OIDC is that it standardizes authentication on top of OAuth2 so that it can be handled consistently. With OIDC handling authentication, OAuth2 can get back to the business of authorization--but specifically, the authorization of applications to act on a user's behalf. Nothing more. Both are really about "**identity**" so I'd call OAuth2 authorization "**identity authorization**."

# The evolution of JWT access tokens

OIDC introduced JWTs for their ID Token but, soon, applications began using JWTs for their access tokens as well. Even though the OAuth2 spec never even had JWTs in view, JWTs have the advantage that they let us verify the token without having to go back to the authorization server--as we _must_ for opaque tokens. I believe JWTs have become so popular because we don't have to take the performance hit of continually going to another server to validate them and allows us to know who a request was made on behalf of, without having to keep session state on your server. We pack the access tokens with "claims" about the user's identity and the scopes they've granted to the client application. Over time, however, we've packed more and more into those JWTs--including application roles and permissions. 

**Note**: There's a case to be made for "identity roles" as opposed to "application roles" being present in JWTs. Identity roles would be those roles that apply throughout the entire universe of services you have. In fact, they allow simple mappings from identity roles to application roles if needed so that you don't have to explicitly handle mappings for each user. However, the concept of "identity roles" seems a bit short-sighted since a so-called "identity role" may cease to apply when the next service is incepted.
{: .notice}

# Conflating identity with permissions

In adding application roles and permissions to our tokens, we've conflated identity with permissions. The access token given to us by the Authorization Server is really about identity or "identity authorization". Yes, it's confusing. How can an "authorization server" not be about authorization? Well, it still is. With OAuth2, subsequent to "authentication" at the Identity Provider, the user then has the ability to grant authorization to the application to act on the their behalf. So despite it being "authorization", it's authorization to act as that "identity"--limited by the granted scopes.

# Consequenses of identity and permission conflation in JWTs

When we go beyond identity in our access tokens, we're making them into something for which they were not intended and reap the consequences of doing so. Some problems of adding permission claims include:
* loss of on-demand access control and permission changes until access token expires
* large JWT payloads
* customizations to or reliance on Identity Providers that lock you in to their products
* loss of single responsibility (i.e. Identity Provider also dealing with application permissions)
* wrangling of resource server frameworks and libraries to parse and handle custom JWT claims.

Even if you "namespace" your roles and permissions to specific applications in your JWT payload, there are still problems. Here's a sample fragment from a decoded JWT with "identity roles" under `roles` and namespaced "application roles" under `resource_access` for the different application audiences of the token `account`, `client-a`, `resource-b`:

{% highlight json %}

{
  "sub": "c4af4e2f-b432-4c3b-8405-cca86cd5b97b",
  "scope": "openid email profile authority-b",
  "preferred_username": "user",
  "roles": [
    "ROLE_USER"
  ],
  "resource_access": {
    "account": {
      "roles": [
        "manage-account",
        "manage-account-links",
        "view-profile"
      ]
    },
    "client-a": {
      "roles": [
        "do-client-a-user-stuff"
      ]
    },
    "resource-b": {
      "roles": [
        "do-resource-b-user-stuff"
      ]
    }
  }
}

{% endhighlight %}

While you can overload the JWT at the Identity Provider by namespacing application roles as we see in the above JWT fragment, it has all the drawbacks we mentioned earlier. Furthermore, while this is a modified example from Keycloak, the same applies to other Identity Providers like Okta, Auth0, and others and they'll almost certainly all differ in structure and setup.

Even if you avoid overloading the JWT at the Identity Provider, beware of doing something worse. I've seen single API Gateways designed to receive the JWT, dispose of it, and create a new custom non-OAuth2 token with roles and permissions baked in. In this case you get all the downsides of baking in application roles and permissions but also lose the access token (for refreshing, standardized libraries and frameworks, etc.) and make your API Gateway overly complex.

# So, I shouldn't put permissions into my JWTs? 

Correct. Don't do it.

> Permissions are **application-specific** and don't belong on an Identity Provider

Permissions are application-specific while access tokens are for any resource server listed in the `aud` claim. Resource servers could very well understand a role or permission differently from each other.

Dominick Baier gives the analogy of showing your drivers license (a kind of "identity" card) in a different country or jurisdiction. Your identity (i.e. Name, Date of Birth, etc.) doesn't change but the laws of the land may differ regarding whether or not you're allowed to purchase alcohol there. Countries having different laws are like applications or resource servers with different authorization rules. When your token reaches a resource server, the token is saying 

> "I'm here representing user _x_'s "identity" and I've been granted the following subset of scopes." 

The question then is, given your presented identity, what should the application or resource server let you do? That's an application-specific question so the answer should be contextualized by the application to which the question is being asked.

# The case for a "policy service"

I've heard people go as far as to say that authorization is just business logic. Despite permissions being application-specific, they don't have to be entirely "business logic" in your code. While I agree that it is largely, if not entirely, business logic, I also believe that a good chunk of that authorization can be done in a standardized or centralizable way that is easily mockable in tests.

For example, your application could ask a logical "policy service" a simple _yes_ or _no_ question: 
> "Given a specific application (or 'policy'), user, and permission name, do they have that permission?"

For example, say you have a note service that stores notes. You could ask the policy service, "given policy 'note', user 'susan', and permission 'CanRead', do they have that permission?" so that if you were trying to get all notes that 'susan' had access to, your logic might look something like this:

{% highlight java %}

List<Note> getNotes(Jwt accessToken) {

  // for access
  if (!policyService.hasPermission("note", jwt, "CanRead")) {
    throw new AccessDeniedException(); // 403
  }

  // for filtering
  if (policyService.hasPermission("note", jwt, "CanReadConfidentialNotes")) {
    return noteRepository.findAll();
  } else {
    return noteRepository.findByConfidentialFalse();
  }
}

{% endhighlight %}

where `policyService.hasPermission` could be mocked out in your tests to return `true` or `false` depending on the particular permission and the claims in your JWT (e.g. "susan" as the `preferred_username`). Sometimes, you'll notice that the business logic is _more_ than calling the policyService. In the above filtering example, you need to know 
1. if the user has permission to read confidential notes, but also
2. if the value of `confidential` on the notes you're returning is `true` or `false` or at least request the right kind of notes from your repository

The second requirement isn't something you can easily store on a generic policy service--it's business logic that requires querying your own domain objects. However, the permission in the first requirement can easily be generalized and handled by a policy service.

If you use a policy service in this way, then it becomes easier to see the division of responsibilities between the policy service and your own application business logic. The policy service would have the responsibility of managing these rules (who has what permission for what policy) and responding to requests like `hasPermission` from applications wanting to know the answers. You business logic can compose policy service calls along with domain-specific calls in order to achieve the access rules or filtering required. Hopefully the above example shows how they can fit together. Testing also should be fairly straighforward. A policy service application could also support a slightly more complex API to return roles, store permissions on specific entities or entity types, etc. but that's beyond the scope of this post. 

Many more questions arise from all this such as:
* what is the cost of all the calls to this centralized policy service?
* what are the caching tradeoffs?
* is it better to just be a side-car service--co-located with the application or even a "starter dependency" that you can include to your application to reduce boiler plate?
* should the policy service have its own UI?
* what policies should govern the policy server itself?
* how is the provisioning of policies accomplished?

I have opinions about these questions but they'll have to wait for another post.

# Conclusion

In conclusion, baking application roles and permissions into JWTs may work for a simple app but the customizations made to do so will lock you into that pattern and limit your ability to spin off new services with the same Identity Provider. It's just not smart.

<!--
hasPermission(policy, userId, userIdRoles, permisionName, entityId, entityType)
hasRole(policy, userId, userIdRoles, roleName)
getPermissionsOnEntity(policy, userId, userIdRoles, entityId, entityType)
getEntitiesWithPermission(policy, userId, userIdRoles, permissionName, entityType)
getUsersWithPermissionOnEntity(policy, permissionName, entityId, entityType)
getUserIdRolesWithPermissionOnEntity(policy, permissionName, entityId, entityType)
getRoles
-->