---
layout: post
title:  "Merry Microservices: An Introduction--Reactive, Full Stack and Policy-Driven on Kubernetes"
author: stephen
tags: [ OAuth, OAuth 2.0, OpenID Connect, Keycloak, Reactive, Webflux, React, Hooks, TypeScript, Tutorial, Spring Boot, Spring Security, R2DBC, Spring Cloud Gateway, Microservices, Jenkins X, Kubernetes, DevOps ]
# image: assets/images/logo-jhipster.svg
featured: true
---

<!-- <img border="0" src="/assets/images/merry-microservices/holly-ivy.svg" width="19%"/> -->
<!-- <img border="0" src="/assets/images/merry-microservices/candy-cane.svg" width="19%"/> -->
<!-- <img border="0" src="/assets/images/merry-microservices/tree.svg" width="19%"/> -->
<img border="0" src="/assets/images/merry-microservices/gift.svg" width="19%"/>
<img border="0" src="/assets/images/merry-microservices/gift2.svg" width="19%"/>
<img border="0" src="/assets/images/merry-microservices/gift3.svg" width="19%"/>
<img border="0" src="/assets/images/merry-microservices/gift.svg" width="19%"/>
<img border="0" src="/assets/images/merry-microservices/gift2.svg" width="19%"/>
<!-- <img border="0" src="/assets/images/merry-microservices/wreath.svg" width="19%"/> -->

# Merry Microserices!

This is the start of a blog series highlighting some of the architectural patterns and frameworks that, in my opinion, make for **Merry Microservices**. 

<!-- On the backend, we'll be using Spring Boot, Spring Webflux, Spring Cloud Gateway, R2DBC, Spring Security 5.2's OAuth 2.0 Client and Resource Server support, Keycloak, OpenID Connect and OAuth 2.0.

On the front-end, we'll creating a CRUD UI with Create React App, TypeScript and Hooks but leveraging the session from a thin server-side Spring Cloud Gateway proxy.

We'll be introducing a "policy service" application that manages authorizations for specific applications based on user identity and the permissions they are granted on the "policy service". -->

* [**Part 1 'Resource Server'--An OAuth 2.0 Resource Server with Webflux and R2DBC**](/blog/2019/12/17/merry-microservices-part1-resource-server) will introduce a simple OAuth 2.0 resource server with Spring Boot Webflux, and Spring Data R2DBC that stores notes.

* [**Part 2 'UI Gateway'--A React UI served by a Spring Cloud Gateway OAuth 2.0 Client**](/blog/2019/12/17/merry-microservices-part2-ui-gateway) will build a CRUD front-end gateway application with Create React App, TypeScript, and Hooks. The JavaScript is served up by Spring Cloud Gateway--acting as a light server-side proxy for the React UI that safely manages OpenID Connect and OAuth 2.0 flows and that relays request back to our note resources server.

* [**Part 3 'Policy Service'--Managing application-specific authorization based on identity and permissions**](/blog/2020/01/12/merry-microservices-part3-policy-service) will demonstrate the place for a "policy service" in this stack to manage the identity permissions (or policies) specific to each application in the architecture rather than overloading the JWT, at the Identity Provider level, with irrelevant permissions.

<!-- * [**Part 4 'Jenkins X'--Bringing it all to Kubernetes**](/blog/2019/12/17/merry-microservices-part4-jenkins-x)  -->
* **Part 4 'Jenkins X'--Bringing it all to Kubernetes** will introduce Jenkins X and how to build and deploy all of this on Google Cloud Platform's managed Kubernetes service, GKE.

<img src="/assets/images/spring-framework.svg" alt="Spring Framework" width="24%"/>
<img src="/assets/images/react.svg" alt="React" width="24%"/>
<img src="/assets/images/openid.svg" alt="OpenID" width="24%"/>
<img src="/assets/images/jenkins-x.svg" alt="Jenkins X" width="24%"/>

Please **follow me** on [twitter](https://twitter.com/doxsees) or [subscribe](/atom.xml) to be updated as each part of this series comes out. 
{: .notice}

If you'd like help with any of these things, find out how what I do and how you can **hire me** at [Simple Step Solutions](https://simplestep.ca)