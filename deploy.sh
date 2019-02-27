STACK_NAME=$1
KEY_NAME=$2

#if [ -f ${KEY_NAME}.pem ]; then
#  rm ${KEY_NAME}.pem
#fi
#
#echo -n "Create Keypair: $KEY_NAME "
#aws ec2 create-key-pair --key-name $KEY_NAME | jq -r ".KeyMaterial" > ./${KEY_NAME}.pem
#chmod 400 ./${KEY_NAME}.pem
#echo "Done."

echo -n "Create Stack: $STACK_NAME "
aws cloudformation deploy \
--stack-name $STACK_NAME \
--capabilities CAPABILITY_IAM \
--template-file  ./aws-refarch-drupal-master.yaml \
--parameter-overrides \
KeyName=$KEY_NAME \
DomainName="" \
DatabaseName="drupal" \
PublicAlbAcmCertificate="" \
AdminEmail="test@test.net" \
AdminUsername="admin" \
DatabaseMasterPassword="Admin123!" \
AdminPassword="admin" \
DatabaseMasterUsername="admin" \
Directory="drupal" \
DatabaseInstanceType="db.t2.small" \
ElastiCacheNodeType="cache.t2.micro" \
WebInstanceType="t2.small"
echo "Done."

#--s3-bucket cnct-cf-templates \
