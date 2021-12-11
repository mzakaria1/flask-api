# Deploy APP on EC2-RDS and EKS using AWS CodeDeploy

### Detailed deployment steps with the resource creation configurations and deployment are in **"deployment.doc"** file

### GitHUB Repo link: 
```
https://github.com/mzakaria1/flask-api
```

### RDS Connection
- Create RDS with the configurations defined in the steps below, create DB in RDS with the name ***recipe_db*** and create DB connection string according to the following format:
```
postgres://YourUserName:YourPassword@YourHostname:5432/YourDatabaseName
```
- Hostname should be the endpoint of RDS
- Replace this string defined in the replacement steps
### Replacement Steps
- Replace the ***pgsql connection string*** with the format defined in the **appspec.yaml**
- Replace the ECR and image name in the ***buildspe.yaml and eks/deployment.yaml*** files
- Replace the **EKS CLuster name** in the ***appspec.yaml*** file 

### Deployment Strategy
- Spinning the EC2 Instance with the **Amazon Linux 2 AMI*** and the user data provided in the file : ***user_data_for_ec2.sh*** which installs the AWS **CodeDeploy agent and Docker** and there is no need to install aws cli becuase it's already installed
- Spinning the RDS and create the database in it and store the username and password. Also replace the ***pgsql connection string*** with the format defined in the appspec.yaml
- Replace the ECR Repository and replace the repository name in ***buildspe.yaml and eks/deployment.yaml*** files
- Other replaceable strings are mentioned in the Replacement Steps
- The CodePipeline will get trigger when there is a push to the master branch of the Github repo and Codebuild will build, tag and push the docker image to ECR using the configuration of buildspec.yaml
- CodeDeploy will deploy the **API on EC2 and EKS** using the agent installed there. 
- The API will connect to the RDS with the **DATABASE_URL** which is the connection string of Postgress RDS
- For **EC2**, API endpoint will use the **Port: 8081**
- For **EKS**, API endpoint will use the **Port: 8080**
## Steps to deploy app on EC2-RDS and EKS using AWS CodeBuild, CodeDeploy and CodePipeline

1. Create VPC, public and private subnets, security group, internet and nat gateway and route-tables
2. Make sure that the private subnets have the internet connectivity
3. Create **EC2 instance in the public subnet** of the VPC with the user data. User data is in the file named: **user_data_for_ec2.sh**
    - EC2 AMI ![alt text](./images/ec2-ami.png)
4. Create **RDS Instance in the private subnet** of the **same VPC**
5. Create database in RDS
    - RDS Configurations ![alt text](./images/rds.png)
    ```bash
    createdb recipe_db
    ```
6. Create **EKS Cluster** and configure the Networking according to the VPC created above
6. Create **CodeBuild Project** to build the docker image for the deployment <br />
    - Image 6.1: ![alt text](./images/codebuild-1.png)
7. Create **CodeDeploy application** and **deployment group** and **attach the EC2 instance** created before
8. Create **CodePipeline** and attach the **Github as source stage**, **CodeBuild as build stage** and **CodeDeploy and deployment group as deploy stage** 
    - Pipeline Settings ![alt text](./images/codepipeline-1.png)
    - Source Stage ![alt text](./images/codepipeline-2.png)
    - Build Stage ![alt text](./images/codepipeline-3.png)
    - Deploy Stage ![alt text](./images/codepipeline-4.png)

