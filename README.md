# Onboarding Example OpenShift resources

1. Create the `kogito` project in your OpenShift cluster:

```
oc create project kogito
```

2. Import the image streams, from the repository root:

```
oc create -f image-stream/hr-service.json
oc create -f image-stream/onboarding-service-service.json
oc create -f image-stream/payroll-service.json
```

3. Import the resources:

```
oc create -f hr-service.json
oc create -f onboarding-service.json
oc create -f payroll-service.json
```

Then just `POST` the following payload to your `onboarding` service:

```
curl -X POST -H 'Content-Type: application/json' -d '{"employee" : {"firstName" : "Mark", "lastName" : "Test", "personalId" : "xxx-yy-zzz", "birthDate" : "1995-12-10T14:50:12.123+02:00", "address" : {"country" : "US", "city" : "Boston", "street" : "any street 3", "zipCode" : "10001"}}}' http://<your-service-hostname>/onboarding
```

Detailed information about this service can be found in:
https://github.com/kiegroup/kogito-examples/blob/master/onboarding-example/onboarding/readme.md
