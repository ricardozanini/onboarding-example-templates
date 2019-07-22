FROM quay.io/kiegroup/kogito-quarkus-centos
COPY onboarding-8.0.0-SNAPSHOT-runner /home/kogito/bin/
COPY javalib/libsunec.so /home/kogito/bin/

