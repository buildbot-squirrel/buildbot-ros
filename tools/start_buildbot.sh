#!/bin/bash
source /home/buildbot/buildbot-env/bin/activate
rm -rf /home/buildbot/buildbot-ros/twistd.log
su buildbot - -c "source /home/buildbot/buildbot-env/bin/activate && buildbot restart /home/buildbot/buildbot-ros"

while [[ $Master=False ]]
  do
		grep -R "BuildMaster is running" /home/buildbot/buildbot-ros/twistd.log
		if [ $? -ne 0 ] ; then
		  Master=False
		  echo "Master still not running"
		else
		  Master=True
		  echo "Master is running"
		  break
		fi
		  sleep 1
  done

su buildbot - -c "source /home/buildbot/buildbot-env/bin/activate && buildslave restart /home/buildbot/rosbuilder1"
su buildbot - -c "source /home/buildbot/buildbot-env/bin/activate && buildslave restart /home/buildbot/rosbuilder2"
