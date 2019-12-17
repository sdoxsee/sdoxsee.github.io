---
layout: post
title:  "Something New"
# author: stephen
# tags: [ OAuth2, Tutorial, JHipster ]
# tags: [ fun ]
# image: assets/images/logo-jhipster.svg
featured: false
---
Overview of SaaS and Open Source IdP Solutions with tradeoffs and recommendations
PKCE over implicit
PKCE and refresh tokens
SCIM
Password flow
Jenkins X Keycloak
Why I like Jenkins X and K8s all the way
GKE on the cheap
Alternative opinion to JWT naysayers
Accelerate Book Review
Talks I'm looking forward to at SP1 2019
Sample Desktop PKCE app

1. note resource server
- r2dbc h2
basic keycloak
2 realms
master (for admin) pw admin/admin
jhipster
- where client defined web_app/web_app
- where user defined, user/user and admin/admin (note: different than master realm's admin user)
- get access token
- create note
- get all notes

2. ui via spring cloud gateway and create react app
- use crud example (using hooks!) and matt raible's crud (using session but with MVC and react router)
spring cloud gateway for SPA
- why webflux?
- why spring cloud gateway? simple and secure token managment and token relay
- handles oauth2/OIDC relay
- keeps tokens secure
- can refresh tokens without redirection
- SSO
- better resource utilization than mvc. less threads -> less memory
- index.html issue
- oidc post_logout_redirect_uri
- /private
- /api/user
- ignore pathPatterns
- proxy
- spring session with redis if you need to scale
- csrf
- spring cloud gateway predicates!

3. policy server (county sheriff) (make the case on simplestep.ca and the examples on sdoxsee.github.com)
- why? because just because your passport says when you were born and where you come from, doesn't mean that your identity brings you the same privileges wherever you go
- authorization server is about users giving authorization to clients to access their information but not about what your application says your user can or cannot do
- identity != authorization
- identity + permissions = authorization
https://leastprivilege.com/2016/12/16/identity-vs-permissions/
- although you want to be "stateless" overloading the token with permissions goes too far. 
- why centralized? reduce duplication, simplify management but not be all end all. there is still business logic that belongs in your app itself
- might relay the token, or might make a specific client credentials calls. latter probably better. client of county sheriff
- local option is not tech-agnositic. commercial is neither SaaS nor freemium. don't recommend hierarchy but simple overrides
- notes secure
- video demo
- open questions (secure policy server, integrations and UI). it's more making a case for this space

4. jenkins x




Practice event sourcing

Focus architecture, java, security, oauth2, openid connect, SAML?, CI/CD on k8s
