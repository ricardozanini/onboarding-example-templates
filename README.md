# Onboarding Example OpenShift resources

1. Create the `kogito` project in your OpenShift cluster:

```
oc new-project kogito
```

2. Import the image streams, from the repository root:

```
oc create -f image-stream/hr-service.json
oc create -f image-stream/onboarding-service.json
oc create -f image-stream/payroll-service.json
```

3. Import the resources:

```
oc create -f hr-service.json
oc create -f onboarding-service.json
oc create -f payroll-service.json
```

4. Add the necessary permissions

```
oc policy add-role-to-user view -z default
```

Then just `POST` the following payload to your `onboarding` service:

```
curl -X POST -H 'Content-Type: application/json' -d '{"employee" : {"firstName" : "Mark", "lastName" : "Test", "personalId" : "xxx-yy-zzz", "birthDate" : "1995-12-10T14:50:12.123+02:00", "address" : {"country" : "US", "city" : "Boston", "street" : "any street 3", "zipCode" : "10001"}}}' http://<your-service-hostname>/onboarding
```

Detailed information about this service can be found in:
https://github.com/kiegroup/kogito-examples/blob/master/onboarding-example/onboarding/readme.md

## KNative installation

To test service discovery with KNative + Istio:

1. Install [KNative Serving Operator](https://github.com/knative/serving-operator) into a OCP 4.x cluster. Will install Istio and KNative in your environment
2. Create a new project to not mess up with the other example:

```
oc new-project kogito-knative
```

3. Create `hr` and `payroll` knative services:

```
oc apply -f knative/knative-hr-service.yaml
oc apply -f knative/knative-payroll-service.yaml
```

4. Provision the `onboarding` service. Doesn't need to be a KNative service. Will integrate with the other two via Istio :)

```
oc create -f image-stream/onboarding-service.json
oc create -f onboarding-service.json
```

5. Now let's add the required permissions

```
oc adm policy add-role-to-user knative-serving-core system:serviceaccount:kogito-knative:default -n default
oc adm policy add-role-to-user view system:serviceaccount:kogito-knative:default -n istio-system
```

Same thing. Just `POST` the following payload to your `onboarding` service:

```
curl -X POST -H 'Content-Type: application/json' -d '{"employee" : {"firstName" : "Mark", "lastName" : "Test", "personalId" : "xxx-yy-zzz", "birthDate" : "1995-12-10T14:50:12.123+02:00", "address" : {"country" : "US", "city" : "Boston", "street" : "any street 3", "zipCode" : "10001"}}}' http://<your-service-hostname>/onboarding
```