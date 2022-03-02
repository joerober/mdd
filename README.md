# CIDR DevOps Workshop 2 - Session 1 Hands-On Lab
In this lab we will using Infrastructure as Code to deploy a basic lab in Cisco Modeling Labs.  We will be doing this by using a small part of the Model Driven DevOps repo which we will learn about later. 

### Clone the repo from the workshop branch.  
By cloning the workshop branch of the repo we will be pulling in everything we need to run the ansible playbook that will deploy our lab.  You can clone the repo with the folowing command:
```
git clone --branch workshop https://github.com/model-driven-devops/mdd.git
```

### Navigate to the mdd directory and update your variables
Once the repo is cloned you will have a new directory named "mdd".  Navigate to the mdd directory, then update your envvars file with your colabot credentials, the cml host that was provided to you by your Lab Mentor, and your lab name which should be your username for this exercise.
```
cd mdd
vi envvars
```

### Create a virtual environment to run your dependencies
It's often preferable to use virtual environments instead of your local (laptop) environment.  Using virtual environments allow you to install the necessary requirements to run the code provided in the repo, without confusing any local requirements you may have for daily use.  
```
python3 -m venv venv-mdd
. ./venv-mdd/bin/activate
```

### Install python requirements via pip
This will install the python requirements that are needed to run ansible in to our virtual environment.
```
pip3 install -r requirements.txt
```
### Source envvars
We will need to source the environment variables we updated earlier so that the playbook will know where to find them.  We also want to install pip3 certifcates to avoid any ssl errors in loading the ansible collection in the next step.  Use the following commands individually to accomplish this:  
```
source ./envvars
pip3 install certifi
```

### Install Ansible Collections
Now that we have our basic requirements installed we will install the ansible modules we will need to run the playbook.  
```
ansible-galaxy collection install -r requirements.yml
```
### Deactivate/reactivate venv
This step isn't always necessary but it serves two purposes for our lab.  First, it works as a reboot for our virtual environment that will clear up any conficting paths with our local environment.  Second, it teaches us how to move in and out of our virtual environments.  The commands below should be run individually.  
```
deactivate
. ./venv-mdd/bin/activate
```

### Run the playbook
Now it's time to build our CML lab!  Run the playbook with the command below, it will take a few minutes to set everything up.  I recommend navigating to your cml host in your browser so you can watch your lab build.  Just don't touch anything until the playbook completes.  
```
ansible-playbook build-cml.yml -v
```

### Run the cml-inventory playbook to get the ip addresses for your devices.  
In addition to deploying and managing your infrastructure, Ansible can be used to gather information as well.  Running this playbook will output facts about our cml lab that will help us in testing the devices. 
```
ansible-playbook cml-inventory.yml -v
```

### Exploration Time!
Take some time here to look at the lab you built in the CML user interface, ssh in to one of your csrs (username: admin, password: admin), ping your other csrs from the one you are currently shelled in to.  

### Clean up your lab
Now that our lab is built and tested, it's time to remove the lab to free up CML space for others in the CIDR community.  Since we deployed the lab with IaC, why not clean it up using a playbook as well.  Run the following command to stop, wipe, and delete you lab.  
```
ansible-playbook clean-cml.yml -vvv
```

