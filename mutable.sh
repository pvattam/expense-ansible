
# Find the servers(Ansible Dynamic Inventory)
aws ec2 describe-instances --filters "Name=tag:Name,Values=${ENV}-${COMPONENT}" --query "Reservations[*].Instances[*].PrivateIpAddress" --output text >inv

# Change the Parameter store having the app version.
aws ssm put-parameter --name "${ENV}.${COMPONENT}.app_version" --value "${APP_VERSION}" --type "String" --overwrite

SSH_PASSWORD=$(aws ssm get-parameter --name "ssh.password" --with-decryption --query 'Parameter.Value' --output text)

# Run ansible push on the servers
ansible-playbook -i inv mutable-deploy.yml -e component=${COMPONENT} -e env=${ENV} -e version=${APP_VERSION} -e ansible_user=centos -e ansible_password=${SSH_PASSWORD}