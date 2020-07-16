# API Monetization in API Manager

_WSO2 United Airport has identified a new business opportunity; since the flights data contain the number of passengers in each flight, it could be used to predict the crowd in the airport for a certain time period. Therefore, the services built around the airport such as the stores and cab services could use this data to optimize the number of employees they require for the services for each day. Thus, the airport decides to provide the flight details API to the public with the subscription capability that generates revenue based on the number of successful requests completed within a time period._

<p align="center">
  <img width="70%" src="../resources/images/apim/api-monetization-0.png">
</p>

API Monetization allows organizations to expand their business and generate higher revenue by exposing their services and data via APIs. API Publishers can publish their APIs with competitive business plans to the Developer Portal. Thereafter, API subscribers (e.g., Application Developers) can discover, subscribe, and invoke these monetized APIs, and pay for their API usage based on dynamic or fixed business plans.

WSO2 API Manager (WSO2 API-M) allows API Publishers to manage, govern, and monetize their APIs based on their business monetization goals. API Publishers can use the monetization capability in WSO2 API Manager to define various business plans for the same service; therefore, API subscribers have the freedom of selecting a preferred business plan as their subscription.

WSO2 API Manager provides an extendable interface that allows API Management solution developers to provide custom implementations with any third-party billing engine for the purpose of monetizing APIs based on paid business plans.

WSO2 API Manager uses [Stripe](https://stripe.com) as its sample implementation billing engine to handle the payments for API monetization. However, you can use any custom implementation with WSO2 API Manager's API Monetization capabilities based on your requirement.

You can learn more about monetization of APIs from [here](https://apim.docs.wso2.com/en/latest/learn/api-monetization/monetizing-an-api/).

This tutorial is part of a tutorial series on API advanced features.

The previous tutorial is on [Different API Protocol Support](5-supported-protocols.md).

Next tutorial is on [Throttling and Access Control](7-throttling-access-control.md).
