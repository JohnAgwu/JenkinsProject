# Create EC2 nodes using custom module 

## ensure you create a bucket to store the state file 
### dev infrastructure creation 
   - cd dev
   - terraform init
   - terraform apply -var-file=apps.tfvars 


### prod infrastructure creation 
   - cd prod
   - terraform init
   - terraform apply -var-file=apps.tfvars 

### to dynamically provide your backend storage, look at "stage" directory 
   - cd stage
   - terraform init -backend-config="bucket=techbleat-terraform-store" -backend-config="key=env/stage/terraform.tfstate" backend-config="region=eu-west-2"
   - terraform apply -var-file=apps.tfvars
