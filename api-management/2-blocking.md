# Block a user/application

_The airport platform analysts identify that a user is misbehaving with a user account with a created application. Therefore, they are required to block the application user temporarily._

<p align="center">
  <img width="70%" src="../resources/images/apim/blocking-0.png">
</p>

#### 1. Add a Deny Policy from Admin Portal

API Manager provides the ability to block an API context, an application, an IP address, an IP range or a user. In this tutorial we will temporarily block admin for the DefaultApplication.

1.1 Navigate to the Admin Portal https://localhost:9443/admin and sign in with admin/admin credentials.

1.2. Click on the **Rate Limiting Policies** to expand it and click on **Deny Policies**. 

<p align="center">
  <img width="70%" src="../resources/images/apim/blocking-1.png">
</p>

1.3. Click **Add Policy** and select **Application** from **Select Condition Type**.

1.4. Enter **admin:DefaultApplication** as the Value.

<p align="center">
  <img width="70%" src="../resources/images/apim/blocking-2.png">
</p>

1.5. Click **Deny**.

1.6. Then, the currently denied items will be listed out under **Deny Policies**. You can temporarily on/off the denying condition by enabling/disabling the **Condition status** that is auto enabled when a denying condition is created.

<p align="center">
  <img width="70%" src="../resources/images/apim/blocking-3.png">
</p>

#### 2. Test the applied Deny Policy

2.1. Navigate to Dev Portal https://localhost:9443/devportal and select the AmericanFlightsAPI from the APIs.

2.2. Click **Try Out** to navigate to the API Console.

2.3. Try to execute a method resource.

2.4. You can observe the following response.

<p align="center">
  <img width="70%" src="../resources/images/apim/blocking-4.png">
</p>

> **Note**: Subscription blocking
>  
>  Apart from the denying(through policies) process the capability of blocking subscriptions is provided  from the Publisher where we can restrict the access for the corresponding API for the particular subscription.

<p align="center">
    <img width="70%" src="../resources/images/apim/blocking-5.png">
</p>

> After blocking the subscription, the users of that subscription will be given 403 Forbidden responses.

<p align="center">
    <img width="70%" src="../resources/images/apim/blocking-6.png">
</p>

This tutorial is part of a tutorial series on API advanced features.

The previous tutorial is on [Adding Role-based Access Control for the APIs](1-role-based-auth.md).

The next tutorial is on [Adding a User Sign Up Workflow](3-sign-up-workflow.md).
