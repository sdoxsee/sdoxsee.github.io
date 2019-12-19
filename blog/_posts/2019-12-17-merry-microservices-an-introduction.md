---
layout: post
title:  "Merry Microservices: An Introduction--Reactive, Full Stack and Policy-Driven on Kubernetes"
author: stephen
tags: [ OAuth2, OpenID Connect, Keycloak, Reactive, Webflux, React, Hooks, TypeScript, Tutorial, Spring Boot, R2DBC, Spring Cloud Gateway, Microservices, Jenkins X, Kubernetes, DevOps ]
# image: assets/images/logo-jhipster.svg
featured: true
---

<img border="0" src="/assets/images/merry-microservices/holly-ivy.svg" width="19%"/>
<img border="0" src="/assets/images/merry-microservices/candy-cane.svg" width="19%"/>
<img border="0" src="/assets/images/merry-microservices/tree.svg" width="19%"/>
<img border="0" src="/assets/images/merry-microservices/gift.svg" width="19%"/>
<img border="0" src="/assets/images/merry-microservices/wreath.svg" width="19%"/>

_Microservices architectures are not trivial_. 

<a align="right" target="_blank"  href="https://www.amazon.ca/gp/product/1942788339/ref=as_li_tl?ie=UTF8&camp=15121&creative=330641&creativeASIN=1942788339&linkCode=as2&tag=simplestep-20&linkId=6a06d8e9aed4924d8cd7ba3f7fc1f15c"><img align="right" border="0" src="//ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&MarketPlace=CA&ASIN=1942788339&ServiceVersion=20070822&ID=AsinImage&WS=1&Format=_SL160_&tag=simplestep-20" ></a><img align="right" src="//ir-ca.amazon-adsystem.com/e/ir?t=simplestep-20&l=am2&o=15&a=1942788339" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />

With many options come many opinions. The [Accelerate](https://www.amazon.ca/gp/product/1942788339/ref=as_li_tl?ie=UTF8&camp=15121&creative=330641&creativeASIN=1942788339&linkCode=as2&tag=simplestep-20&linkId=6a06d8e9aed4924d8cd7ba3f7fc1f15c) book's research has finally shown **evidence** (not mere "opinion") that certain specific practices lead to accelerated software deliver performance! I don't have the time to go into all the details of that here except to say that [Jenkins X](https://jenkins-x.io) (not to be confused with Jenkins) has latched onto this concept and built an opinionated open source tool around Kubernetes, arguably de facto standard for cloud applications, that follows these evidence-based practices--allowing people to follow "convention over configuation" in DevOps. 

> Coupling ourselves to the right things via best-practice and standardization will accelerate software development performance.
<!-- {: .notice} -->

I've spent most of my career doing Java development--especially with the Spring Framework. Java gets a fair bit of hate--some of it is merited while much of it is [myth](https://developer.okta.com/blog/2019/07/15/java-myths-2019). Personally, I love it. One downside, however, is that it tends to use a lot of memory; traditional blocking architectures and thread pools at scale really bring this to light. 

With Spring Webflux, the Spring Framework has been re-architected on [Project Reactor](https://projectreactor.io/) and [Netty](https://netty.io/) to bring about more asynchronous, event-driven, non-blocking applications (i.e. "Reactive"). Spring Webflux has some advantages over Spring MVC including more efficient resource utilization (i.e. less threads => less memory). Those lead to cheaper cloud costs and more robust services. I like that. I find it hard to justify the resource requirements for the excessive threads in Spring MVC but, since I still love Java, Spring Webflux makes "Java in the cloud" much more palatable. It also can leverage the awesome autoconfiguration features of Spring Boot that can make it super-easy to use. Webflux has some limitations (e.g. lack of non-blocking libraries, etc.) and differences from the very support-rich servlet-based stack but we'll see that it's pretty cool!

<img src="/assets/images/spring-framework.svg" alt="Spring Framework" width="24%"/>
<img src="/assets/images/react.svg" alt="React" width="24%"/>
<img src="/assets/images/openid.svg" alt="OpenID" width="24%"/>
<img src="/assets/images/jenkins-x.svg" alt="Jenkins X" width="24%"/>

# Merry Microserices!

This is the start of a blog series highlighting some of the architectural patterns and frameworks that, in my opinion, make for **Merry Microservices**.

* [**Part 1 'Resource Server'--An OAuth2 Resource Server with Webflux and R2DBC**](/blog/2019/12/17/merry-microservices-part1-resource-server) will introduce a simple OAuth2 resource server with Spring Boot Webflux, and Spring Data R2DBC that stores notes.

* [**Part 2 'UI Gateway'--A React UI served by a Spring Cloud Gateway OAuth2 Client**](/blog/2019/12/17/merry-microservices-part2-ui-gateway) will build a CRUD front-end gateway application with Create React App, TypeScript, and Hooks. The JavaScript is served up by Spring Cloud Gateway--acting as a light server-side proxy for the React UI that safely manages OpenID Connect and OAuth2 flows and that relays request back to our note resources server.

* [**Part 3 'Policy Service'--Application authorization management based on identity and permissions**](/blog/2019/12/17/merry-microservices-part3-policy-service) will demonstrate the place for a "policy service" in this stack to manage the identity permissions (or policies) specific to each application in the architecture rather than overloading the JWT, at the Identity Provider level, with irrelevant permissions.

* [**Part 4 'Jenkins X'--Bringing it all to Kubernetes**](/blog/2019/12/17/merry-microservices-part4-jenkins-x) will introduce Jenkins X and how to build and deploy all of this on Google Cloud Platform's managed Kubernetes service, GKE.

Please **follow me** on [twitter](https://twitter.com/doxsees) or [subscribe](/atom.xml) to be updated as each part of this series comes out. 
{: .notice}

If you'd like help with any of these things, find out how what I do and how you can **hire me** at [Simple Step Solutions](https://simplestep.ca)