---
layout: post
title:  "Multi-tenant OAuth 2.0 Resource Servers (with Spring Security 5)"
author: stephen
tags: [ OAuth, OAuth 2.0, Multitenancy, Multi-tenant, Resource Server, Users, User Pool, Tenant, Authorization Server, Identity Provider, Spring Boot, Spring Security, JWT, Okta, Auth0, FusionAuth ]
image: 
  path: /assets/images/multi-tenant-oauth-2.0-resource-servers/multi-tenant.png
  thumbnail: assets/images/multi-tenant-oauth-2.0-resource-servers/multi-tenant.png
  caption: "https://fr-fr.roomlala.com//prod/file/welchome/upload/1058.png"
featured: true
---

## TLDR;

Check out the [github repo](https://github.com/sdoxsee/examples/tree/master/multi-tenant-jwt-resourceserver).

{% include toc %}

It used to be common for organizations to have only internal users that would access systems and software on-premise. With the advent of mobile devices and the explosion of external-facing web applications, those norms have been disrupted. 

Organizations differentiate themselves by offering their external users (e.g. customers) the ability to self-serve--often with their own user accounts and applications that pull data from the same source systems that internal users would work from.

## User pools and tenants

It's often advantageous for both internal and external users to access the organization's data from the same APIs. Depending on how users are setup, you may have internal and external users in the same pool of users--differentiated only by roles or the applications they are associated with. Another common approach is to have internal and external users in completely separate user pools.

In IAM (Identity and Access Management), a single "identity provider" (or "tenant") is associated with a single user pool. If you have a single user pool for both your internal and external users, you may experience a challenge if those users can be both internal and external. Take a group benefits company, for example, that uses itself for group benefits. You have internal users in sales, new business, customer service, etc. You also have external users that act as the plan administrator for the company and the plan members themselves. In this case, there would be overlap between the two logical user groups. Do you really want users to sign in with their regular plan member "hat" on with the same credentials they use when they're wearing their customer service "hat"? Perhaps, but it might make sense to keep such user pools separate. 

![multi-tenant](/assets/images/multi-tenant-oauth-2.0-resource-servers/multi-tenant.svg)

## When to use more than one tenant

It really depends. The above scenario is perhaps a case for a multi-tenant solution. Another might be where you offer whitelabeled SaaS software and your customers have customers themselves (e.g. think Shopify, etc.). You probably don't want to mix those user pools! FusionAuth (a pretty decent identity provider for small to medium sized organizations), has some worthwhile [articles](https://fusionauth.io/learn/expert-advice/identity-basics/multi-tenancy-vs-single-tenant-idaas-solutions/) on the subject.

Because of the complexities involved, you may want to seek some guidance with your IAM architecture--if so so, feel free to get in touch. It's certainly not one-size-fits-all and it's something that you want to get right. There are tradeoffs and nuances that need to be considered and, as the organization evolves, so too may your IAM decisions. It's also important to understand where the multitenancy, if any, is taking place. Is it at the Client, the authorization server itself, the resource server only?

> Reasons for multitenancy will vary but the crux of multitenancy is dealing with separate user pools. 

## Challenges of supporting multitenancy

Modern APIs are protected by means of OAuth 2.0. authorization servers (i.e. the identity provider, issuer, or tenant) commonly grant signed JWT access tokens to client applications once a user has authorized the client to make request on their behalf. Client applications can then make requests to resource servers (i.e APIs) by including the access token as a header. However, if you're building APIs for core organizational services where you have users that come from different tenants, the issuer of the access tokens will be different and the user identifiers (usually the ```sub``` claim) in the tokens will come from completely different user pools. The main problem of tokens coming from different tenant issuers is that the resource server (or API) must first inspect the ```iss``` claim (i.e. the issuer) in the JWT to find out which public key to use to validate the signature on the token.

Many frameworks, whether in Java, Node, Rails, etc., have _basic_ OAuth 2.0 support. 

![Spring Security](/assets/images/multi-tenant-oauth-2.0-resource-servers/spring.svg) 

Spring Security 5 has _excellent_ support for OAuth 2.0. The default autoconfiguration for Spring Boot OAuth 2.0 resource server easily handles token validation for single tenant scenarios by leveraging the ```spring.security.oauth2.resourceserver.jwt.issuer-uri``` property. 

But what if you have multiple tenants? 

Spring Security's suppport for resource server multitenancy is decent and evolving. They provide some [guidance](https://docs.spring.io/spring-security/site/docs/current/reference/html5/#oauth2resourceserver-multitenancy) on options for implementing it if you need it. Unfortunately, there are some typos in the code snippets, and while code snippets are helpful, it still takes time to set things up--as there's no working git repository example (that I know of) that puts all the pieces together--especially if you want to avoid parsing the JWT twice on every request!

## Github examples

That's why I created an [example repo](https://github.com/sdoxsee/examples/tree/master/multi-tenant-jwt-resourceserver) that can be cloned and illustrates the two competing approaches they outline for multitenancy on OAuth 2.0 resource servers. I won't repeat the great [documentation](https://docs.spring.io/spring-security/site/docs/current/reference/html5/#oauth2resourceserver-multitenancy) but essentially they have a simple (but less efficient) approach and a more complex (but more efficient and configurable) approach. I provide a multimodule project so that you can try out both.

You'll, of course, need two tenants or OAuth 2.0 authorization servers--I use Google and Auth0 in the example, but you can use whatever you want. Why not try two separate tenants on Okta and create an OAuth 2.0 app on each. [Here's how](https://developer.okta.com/docs/guides/implement-oauth-for-okta/create-oauth-app/).

Once you've created your two tenants, run either the simple or complex API by `cd`ing into your chosen module and running the following:

{% highlight bash %}
APP_ISSUER_0_=https://yourprovider.com/tenant0 \
APP_ISSUER_1_=https://yourprovider.com/tenant1 \
mvn spring-boot:run
{% endhighlight bash %}

You should get a 401 at http://localhost:8080--indicating your API is secured.

![401](/assets/images/multi-tenant-oauth-2.0-resource-servers/401.png)

Once you've finish your client registrations, use curl, Postman, or [Insomnia](https://insomnia.rest/) as your OAuth 2.0 2.0 Client to fire requests at the example resource servers. Configure your client with the client id, client secret, redirect/callback URL, authorization and token endpoints, as well as any scopes you've defined. Depending on your choice of authorization server, you'll also need to register an API with scopes that your client will need to reference in order to obtain tokens. (If this is confusing, please drop a comment and I can unpack this more)

Anyway, once you're able to obtain access tokens, requests made with tokens issued from either tenant should give you 200 "hello" response. Simply set the `Authorization: Bearer <JWT>` header with your JWT access token.

> **Tip**: If your access token is a JWT, it will start with `ey...`

![401](/assets/images/multi-tenant-oauth-2.0-resource-servers/insomnia200.png)

## Conclusion

I hope that's been helpful and puts you a step ahead in handling multitenancy on your OAuth 2.0 resource server APIs.