export const handler = async (event) => {
    const response = {
        message: "Hello from SkillPilote Day 12!",
        service: "AWS Lambda",
        region: process.env.AWS_REGION,
        path: event?.rawPath ?? "/",
        method: event?.requestContext?.http?.method ?? "TEST"
    };

    return {
        statusCode: 200,
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(response)
    };
};
