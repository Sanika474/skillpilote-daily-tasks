
import argparse
import boto3
from botocore.exceptions import BotoCoreError, ClientError

TAG_KEY = "Project"
TAG_VALUE = "BeginnerRoadmap"


def main():
    parser = argparse.ArgumentParser(
        description="Preview or apply AWS resource tags."
    )
    parser.add_argument(
        "--regions",
        nargs="+",
        default=["ap-south-1"],
        help="AWS regions to scan",
    )
    parser.add_argument(
        "--apply",
        action="store_true",
        help="Apply tags; without this flag, preview only",
    )
    args = parser.parse_args()

    session = boto3.Session()
    total = 0

    for region in args.regions:
        print(f"\nChecking region: {region}")
        client = session.client(
            "resourcegroupstaggingapi",
            region_name=region,
        )

        try:
            paginator = client.get_paginator("get_resources")

            for page in paginator.paginate():
                for resource in page.get("ResourceTagMappingList", []):
                    arn = resource["ResourceARN"]
                    tags = {
                        tag["Key"]: tag["Value"]
                        for tag in resource.get("Tags", [])
                    }

                    total += 1

                    if tags.get(TAG_KEY) == TAG_VALUE:
                        print(f"Already tagged: {arn}")
                        continue

                    if args.apply:
                        result = client.tag_resources(
                            ResourceARNList=[arn],
                            Tags={TAG_KEY: TAG_VALUE},
                        )
                        failures = result.get("FailedResourcesMap", {})
                        if arn in failures:
                            print(f"FAILED: {arn} - {failures[arn]}")
                        else:
                            print(f"TAGGED: {arn}")
                    else:
                        print(f"PREVIEW: {arn}")
                        print(f"  {TAG_KEY}={TAG_VALUE}")

        except (BotoCoreError, ClientError) as error:
            print(f"ERROR in {region}: {error}")
            return 1

    print(f"\nResources discovered: {total}")
    if not args.apply:
        print("Preview only. No changes made.")
        print("Use --apply only after reviewing the resources.")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
