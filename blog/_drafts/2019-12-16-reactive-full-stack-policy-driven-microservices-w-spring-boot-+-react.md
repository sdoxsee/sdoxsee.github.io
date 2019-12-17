---
layout: post
title:  "Reactive Full Stack Policy-Driven Microservices with Spring Boot and React"
author: stephen
tags: [ OAuth2, OpenID Connect, Keycloak, Reactive, Webflux, React, Hooks, Tutorial, Spring Boot, R2DBC, Spring Cloud Gateway, Microservices, Jenkins X, Kubernetes ]
# image: assets/images/logo-jhipster.svg
featured: true
---

Microservices architectures are not trivial. There are many opinions about which way to go. I suppose this is another opinion.

At this point in time I won't argue that Webflux is the way to go (as there are some limitations and differences from the very support-rich MVC ecosystem.) I'm actually curious about playing more with NestJS more as it offers quality architecture (IMO) to NodeJS, TypeScript (yes, I love my static typing), and benefits from the slimmer resource requirements when you're building cloud native systems. I find it hard to justify the resource requirements for excessive threads in Spring MVC but, since I still love Java, Spring Webflux makes Java more paletable.

I'll be starting a blog series to highlight some of the architectural patterns that I think are quite compelling.

Part 1 will be introduction a simple confidential note OAuth2 resource server with Spring Boot Webflux, and Spring Data R2DBC.

Part 2 will be building a CRUD front-end gateway application with create-react-app and served up by Spring Cloud Gateway that acts as a light server-side proxy for the React UI that safely manages OpenID Connect and OAuth2 flows and that relays request back to our note service.

Part 3 will feature demonstrate the place for a policy service in this stack to manage the identity permissions (or policies) specific to each application in the architecture

Part 4 will introduce how to deploy all of this on Google Cloud Platform's managed Kubernetes service using Jenkins X.

Please subscribe or follow me on twitter to be updated as each part comes out.

<!-- 1. note resource server
- r2dbc h2
basic keycloak
2 realms
master (for admin) pw admin/admin
jhipster
- where client defined web_app/web_app
- where user defined, user/user and admin/admin (note: different than master realm's admin user)
- get access token
- create note
- get all notes -->
