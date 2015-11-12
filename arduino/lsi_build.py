import sys
import time
import jenkinsapi.api
from build_light import * #red_solid, green_solid, yellow_fading

JENKINS_URL = "http://jenkins.ccbn.net:8080/"

if __name__ == "__main__":
    
    job_name = sys.argv[1]

    while True:
        build = jenkinsapi.api.get_latest_build(JENKINS_URL, job_name)

        if build.is_running():
            yellow_fading()

        elif build.is_good():
            green_solid()

        else:
            red_solid()

        time.sleep(1)

    
