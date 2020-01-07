---
layout: post
title:  "Merry Microservices: Part 3 'Policy Service'--Application authorization management based on identity and permissions"
author: stephen
tags: [ OAuth2, Keycloak, Reactive, Webflux, Tutorial, Spring Boot, R2DBC, Microservices, React, Create React App, TypeScript, Hooks, OpenID Connect ]
# image: assets/images/react.svg
featured: true
---

This is Part 3 of the series "[Merry Microservices](/blog/2019/12/17/merry-microservices-an-introduction)"

We'll be going back to the confidential note service from [Part 1](/blog/2019/12/17/merry-microservices-part1-resource-server) but we'll further our authorization, beyond what OAuth2 provides, by calling a policy service where application-specific permissions are managed.

The source can be found on github at [https://github.com/sdoxsee/merry-microservices-note](https://github.com/sdoxsee/merry-microservices-note).

<img border="0" src="/assets/images/merry-microservices/gift.svg" width="19%"/>
<img border="0" src="/assets/images/merry-microservices/gift2.svg" width="19%"/>
<img border="0" src="/assets/images/merry-microservices/gift3.svg" width="19%"/>
<img border="0" src="/assets/images/merry-microservices/gift.svg" width="19%"/>
<img border="0" src="/assets/images/merry-microservices/gift2.svg" width="19%"/>

{% include toc %}

# Preamble

In order to keep this introduction short, I recommend you first read "[Stop overloading JWTs with permission claims](/blog/2020/01/03/stop-overloading-jwts-with-permission-claims)" as it provides the rationale for going this route for authorization.

So, in order to have 
1. the authorization granularity we need for our applications and 
2. the permission centralization we need to avoid building the same services over and over,
we'll use a centralized "policy service" that answers whether or not a user has a given permission for a given application (or "policy")

What "policy service" are we going to use? Well, there's the community version of PolicyServer for .NET but that won't work with anything other than Microsoft. The commercial version could serve our purposes but it 
1. doesn't have a freemium model (other than the single application community version)
2. doesn't have a SaaS experience (only docker or self-hosted after paying)
3. doesn't advertise any public documentation
4. complicates policies by letting them be hierarchical

As a result, I built my own with JHipster that I hope to make a hosted SaaS soon and/or open source. We'll interact with that for the duration of this post.

Let's dive right in.

# Customizing our note service for more fine-grained authorization

Previously we only let Spring Security filters determine if we should return a 401 "unauthorized" or not. Perhaps we should have also added a configuration to enforce scope authorization by ensuring that a scope like `authority-note` came with the access token or else return a 403 "access denied".

{% highlight java %}

@EnableWebSecurity
public class ResourceServerConfig extends WebSecurityConfigurerAdapter {

  // @formatter:off
  @Override
  protected void configure(HttpSecurity http) throws Exception {
    http
      .authorizeRequests(authorizeRequests ->
        authorizeRequests
          .mvcMatchers("/**").access("hasAuthority('SCOPE_authority-note')")
          .anyRequest().authenticated())
      .oauth2ResourceServer(oauth2ResourceServer ->
        oauth2ResourceServer
          .jwt());
  }

{% endhighlight %}

Let's go a bit futher, though, by introducing a `PolicyService` client bean that will query our "policy service" application.

```
@Service
class PolicyService {

  @Value("${app.policy-name}")
  private String appPolicyName;

  private final WebClient webClient;

  public PolicyService(WebClient webClient) {
    this.webClient = webClient;
  }

  @Transactional(readOnly = true)
  public Mono<Boolean> hasPermission(Jwt jwt, String entityId, String entityType, String permission) {
    return this.webClient
        .get()
        .uri(uriBuilder -> uriBuilder
              .path("/api/policy-evaluation")
              .queryParam("policy", appPolicyName)
              .queryParam("entityId", entityId)
              .queryParam("entityType", entityType)
              .queryParam("permission", permission)
              .build())
        .headers(headers -> headers.setBearerAuth(jwt.getTokenValue()))
        .retrieve()
        .bodyToMono(Boolean.class);
  }
}
```

```
app:
  policy-name: note
```

```
  @Bean
  WebClient webClient(ServicesConfig servicesConfig) {
    return WebClient.create("http://localhost:8080/policy-service");
  }
```



method level security with preauthorize
or imperatively

boolean policyService.hasPermission(policy, userId, userIdRoles, permisionName, entityId, entityType)

might want to use that information to 
1) deny access, or
2) filter results

Let's configure

default -> return false for all
add policy for application
add roles for policy
add permissions for policy to roles
add users with roles
for specific user
- add permissionoverrides overall
- add permissionoverrides to entity type
- add permissionoverrides to specific entity id
or
identity role mapping so we don't need to create users (although users could be provisioned)

examples of (swagger?)
1) locked down permission
2) open for type in general
3) locked for specific id of that type

relay token and use that user and id roles set
or
call directly for specific user with client credentials

canWrite?
1) no
2) notes
3) but not node 1

canReadConfidential
1) node 2 (won't come back!)

canRead (for ui) call policy service directly from react (via proxy and token relay)
1) show nothing!

So, now were using a policy service to control authorization for application-specific permissions

In the meantime, check out [Part 1](/blog/2019/12/17/merry-microservices-part1-resource-server)