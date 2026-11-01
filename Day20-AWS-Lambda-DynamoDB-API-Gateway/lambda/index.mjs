
import { randomUUID } from "node:crypto";

import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import {
  DynamoDBDocumentClient,
  PutCommand
} from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({
  region: process.env.AWS_REGION || "ap-south-1"
});

const dynamodb = DynamoDBDocumentClient.from(client);

const TABLE_NAME = process.env.TABLE_NAME;

export const handler = async (event) => {
  try {
    if (!TABLE_NAME) {
      throw new Error("DynamoDB table configuration is missing");
    }

    let body;

    try {
      body = JSON.parse(event.body || "{}");
    } catch {
      return response(400, {
        message: "Invalid JSON request body"
      });
    }

    const { name, email } = body;

    if (
      typeof name !== "string" ||
      !name.trim() ||
      typeof email !== "string" ||
      !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)
    ) {
      return response(400, {
        message: "Valid name and email are required"
      });
    }

    const visitor = {
      visitorId: randomUUID(),
      name: name.trim(),
      email: email.trim(),
      visitTime: new Date().toISOString()
    };

    await dynamodb.send(
      new PutCommand({
        TableName: TABLE_NAME,
        Item: visitor
      })
    );

    return response(201, {
      message: "Visitor recorded successfully",
      visitorId: visitor.visitorId
    });

  } catch (error) {
    console.error("Visitor insertion failed:", error);

    return response(500, {
      message: "Internal server error"
    });
  }
};

function response(statusCode, data) {
  return {
    statusCode,
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(data)
  };
}
