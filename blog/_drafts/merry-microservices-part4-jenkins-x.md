---
layout: post
title:  "Merry Microservices: Part 4 'Jenkins X'--Bringing it all to Kubernetes"
author: stephen
tags: [ OAuth2, Keycloak, Reactive, Webflux, Tutorial, Spring Boot, R2DBC, Microservices, React, Create React App, TypeScript, Hooks, OpenID Connect ]
# image: assets/images/react.svg
featured: true
---

This is Part 4 of the series "[Merry Microservices](/blog/2019/12/17/merry-microservices-an-introduction)"

<img border="0" src="/assets/images/merry-microservices/holly-ivy.svg" width="19%"/>
<img border="0" src="/assets/images/merry-microservices/candy-cane.svg" width="19%"/>
<img border="0" src="/assets/images/merry-microservices/tree.svg" width="19%"/>
<img border="0" src="/assets/images/merry-microservices/gift.svg" width="19%"/>
<img border="0" src="/assets/images/merry-microservices/wreath.svg" width="19%"/>

<!-- {% include toc %} -->

# Preamble

_Microservices architectures are not trivial_. 

<a align="right" target="_blank"  href="https://www.amazon.ca/gp/product/1942788339/ref=as_li_tl?ie=UTF8&camp=15121&creative=330641&creativeASIN=1942788339&linkCode=as2&tag=simplestep-20&linkId=6a06d8e9aed4924d8cd7ba3f7fc1f15c"><img align="right" border="0" src="//ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&MarketPlace=CA&ASIN=1942788339&ServiceVersion=20070822&ID=AsinImage&WS=1&Format=_SL160_&tag=simplestep-20" ></a><img align="right" src="//ir-ca.amazon-adsystem.com/e/ir?t=simplestep-20&l=am2&o=15&a=1942788339" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />

With many options come many opinions. The [Accelerate](https://www.amazon.ca/gp/product/1942788339/ref=as_li_tl?ie=UTF8&camp=15121&creative=330641&creativeASIN=1942788339&linkCode=as2&tag=simplestep-20&linkId=6a06d8e9aed4924d8cd7ba3f7fc1f15c) book's research has finally shown **evidence** (not mere "opinion") that certain specific practices lead to accelerated software deliver performance! I don't have the time to go into all the details of that here except to say that [Jenkins X](https://jenkins-x.io) (not to be confused with Jenkins) has latched onto this concept and built an opinionated open source tool around Kubernetes, arguably de facto standard for cloud applications, that follows these evidence-based practices--allowing people to follow "convention over configuation" in DevOps. 

> Coupling ourselves to the right things via best-practice and standardization will accelerate software development performance.
<!-- {: .notice} -->

# Coming Soon!

In the meantime, check out [Part 1](/blog/2019/12/17/merry-microservices-part1-resource-server)