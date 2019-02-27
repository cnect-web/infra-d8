ASG_NAME=$(aws autoscaling describe-auto-scaling-groups --query "AutoScalingGroups[*].AutoScalingGroupName | [0]" --output text)
ASG_STATUS=$(aws autoscaling describe-auto-scaling-groups --query "AutoScalingGroups[*].DesiredCapacity | [0]" --output text)

echo $ASG_STATUS

if [ "$ASG_STATUS" -eq 0 ]; then
  echo "Enabling Bastion..."
  DISCARD=$(aws autoscaling update-auto-scaling-group --auto-scaling-group-name $ASG_NAME --desired-capacity 1)
  echo "Done."
else
  echo "Disabling Bastion..."
  DISCARD=$(aws autoscaling update-auto-scaling-group --auto-scaling-group-name $ASG_NAME --desired-capacity 0)
  echo "Done."
fi
