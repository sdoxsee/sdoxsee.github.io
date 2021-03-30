---
layout: post
title:  "Environment Variable Generator for Spring Boot"
author: stephen
tags: [ Spring Boot, Externalized Configuration, Relaxed-Binding, Environement Variables, Kubernetes ]
image: 
  path: /assets/images/2021/03/30/env-gen.png
  thumbnail: /assets/images/2021/03/30/env-gen.png
  # caption: "https://spring.io/images/spring-logo-9146a4d3298760c2e7e49595184e1975.svg"
featured: true
---

I like setting and overriding Spring Boot app configuration using environment variables.

I got tired of creating them by hand, so I created a little [web app](https://env.simplestep.ca) to generate them from Spring Boot YAML according to the relaxed-binding naming rules.

{% highlight yaml %}
foo-bar:
  baz:
    - value1
    - value2
  enabled: false
{% endhighlight %}

becomes

{% highlight shell %}
FOOBAR_BAZ_0_=value1
FOOBAR_BAZ_1_=value2
FOOBAR_ENABLED=false
{% endhighlight %}

Please try it and share it!

> [https://env.simplestep.ca](https://env.simplestep.ca)

Hope it helps you too!