How ideally a code looks like:
<img width="1000" height="1000" alt="image" src="https://github.com/user-attachments/assets/14be981d-00b2-4e6f-94cd-79935e0ef3d2" />
But I got a lot of errors while working on this script. Here are the details and how it got solved:
- The error looks like these:
   <img width="2048" height="885" alt="image" src="https://github.com/user-attachments/assets/3dcb4031-a348-4364-925a-d8aa5a2fa7c5" />

   So Technically there are two errors:
    1. "DockerFile" is not present.
       <img width="2048" height="123" alt="image" src="https://github.com/user-attachments/assets/6c0bc3ee-3573-4bf8-84c2-f2d015f755ce" />
       Why we see this error?
       - because very easily we can guess that docker needs to find the DockerFile in order to build but in that present directory DockerFile is not there.
       - So somehow we need to go to the directory where Dockerfile is present and we can achieve it via "cd <directory-name>"
       <img width="642" height="105" alt="image" src="https://github.com/user-attachments/assets/ce8cec52-f323-4995-acd7-013984739269" />
       Above image: handling the error by cloning the django-repo and then entering the directory itself, so that docker will not complain in next steps
    2. Permission denied at “/var/run/docker.sock”.
       <img width="1365" height="96" alt="image" src="https://github.com/user-attachments/assets/b43a7e7b-583e-43fc-a1fc-f93207cd6809" />
       To solve this: we need to give current user the owner role for this path
       <img width="583" height="146" alt="image" src="https://github.com/user-attachments/assets/115f566b-9f0c-418f-8fd5-f0054637d421" />
    3. Deployment is succesfull but container is not starting. instead it getting terminated.
       Solution: as this is a django app probably in dockerfile, we need to check if the command is enabled to run the server. if not we can include the command in the script to run as automation
       SO technically to run a django server from local machine we have to use "./manage.py runserver 0.0.0.0:8000"
    4. Probably docker compose is not installed so it can say "docker compose is not a valid command". Please use the docker-compose installation docs and check it then "docker-compose --version"





