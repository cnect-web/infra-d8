USER="ec2-user"
STACK_NAME="ConnectWebTeam"
# Get the bastion IP.
BASTION=$(aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:logical-id,Values=BastionAutoScalingGroup" "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].PublicIpAddress" --output text)
# Get the web instance IPs.
INSTANCE=$(aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:logical-id,Values=WebAutoScalingGroup" "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].PrivateIpAddress | [0]" --output text)
echo $BASTION
echo $INSTANCE
ssh-add connect_web_team_prod.pem
ssh -A -i connect_web_team_prod.pem -t ${USER}@${BASTION} ssh ${USER}@${INSTANCE}
