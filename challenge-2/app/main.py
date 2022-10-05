import boto3
import json
from flask import Flask, render_template

app = Flask(__name__)
client = boto3.client('ec2')

@app.route("/")
def show_private_instance_details():
    subnets_response = client.describe_subnets()
    subnets = subnets_response['Subnets']
    filtered = filter(filter_private_subnet_1, subnets)
    private_subnet_1_id = list(filtered)[0]["SubnetId"]

    instances = []
    reservations = client.describe_instances()["Reservations"]
    for reservation in reservations:
        for instance in reservation["Instances"]:
            if instance["SubnetId"] == private_subnet_1_id:
                instances.append([instance["InstanceId"], instance["State"]["Name"], instance["LaunchTime"],
                instance["Placement"]["AvailabilityZone"]])
    return render_template("instance.html", instances_data=instances)


def filter_private_subnet_1(subnet):
    tags = subnet["Tags"]
    for tag in tags:
        if tag["Key"] == "Name" and tag["Value"] == "Private Subnet 1":
            return True

    return False

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True, port=80)
