
function kcat-prd(){
    local myPass=$(gopass show misc/ecom-kafka-prd-pass)
    local myUser=$(gopass show misc/ecom-kafka-prd-user)
    kafkacat -b kafka.gce.prod.rd-ecom.com:9094 -C -X security.protocol=SASL_SSL -X sasl.mechanisms=PLAIN -X ssl.ca.location=/Users/omer.genc/development/kafka/kafka-broker-ca.pem -X sasl.username=$myUser -X sasl.password=$myPass -t $@
}

function kcat-prd-list(){
    local myPass=$(gopass show misc/ecom-kafka-prd-pass)
    local myUser=$(gopass show misc/ecom-kafka-prd-user)
    kafkacat -b kafka.gce.prod.rd-ecom.com:9094 -X security.protocol=SASL_SSL -X sasl.mechanisms=PLAIN -X ssl.ca.location=/Users/omer.genc/development/kafka/kafka-broker-ca.pem -X sasl.username=$myUser -X sasl.password=$myPass -L $@
}

function kcat-int(){
    # kafkacat -b "outside-kafka-0.service.int.rewe-big-data.com:32400,outside-kafka-1.service.int.rewe-big-data.com:32401,outside-kafka-2.service.int.rewe-big-data.com:32402,outside-kafka-3.service.int.rewe-big-data.com:32403" -X session.timeout.ms=200 -X max.poll.interval.ms=200 -X queued.max.messages.kbytes=100 -X queued.min.messages=1 -X fetch.message.max.bytes=524288 -X fetch.min.bytes=1 -X fetch.wait.max.ms=100 -X auto.commit.interval.ms=100 -t $@
    kafkacat -b "outside-kafka-0.service.int.rewe-big-data.com:32400,outside-kafka-1.service.int.rewe-big-data.com:32401,outside-kafka-2.service.int.rewe-big-data.com:32402,outside-kafka-3.service.int.rewe-big-data.com:32403" -t $@
}

function kcat-int-list(){
    kafkacat -b "outside-kafka-0.service.int.rewe-big-data.com:32400,outside-kafka-1.service.int.rewe-big-data.com:32401,outside-kafka-2.service.int.rewe-big-data.com:32402,outside-kafka-3.service.int.rewe-big-data.com:32403" -L $@
}

function kcat-ecom-int(){
    local myPass=$(gopass show misc/ecom-kafka-int-pass)
    local myUser=$(gopass show misc/ecom-kafka-int-user)
    kafkacat -b kafka.gce.int.rd-ecom-test.com:9094 -C -X security.protocol=SASL_SSL -X sasl.mechanisms=PLAIN -X ssl.ca.location=/Users/omer.genc/development/kafka/kafka-broker-ca.pem -X sasl.username=$myUser -X sasl.password=$myPass -t $@
}

function kcat-ecom-int-list(){
    local myPass=$(gopass show misc/ecom-kafka-int-pass)
    local myUser=$(gopass show misc/ecom-kafka-int-user)
    kafkacat -b kafka.gce.int.rd-ecom-test.com:9094 -X security.protocol=SASL_SSL -X sasl.mechanisms=PLAIN -X ssl.ca.location=/Users/omer.genc/development/kafka/kafka-broker-ca.pem -X sasl.username=$myUser -X sasl.password=$myPass -L $@
}
