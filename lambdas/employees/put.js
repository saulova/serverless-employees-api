const AWS = require("aws-sdk");
const dynamo = new AWS.DynamoDB.DocumentClient();

const handleEvent = require("/opt/nodejs/handleEvent");
const response = require("/opt/nodejs/handleResponse");

exports.handler = async (event) => {
  try {
    const table = "employees";
    const eventInfo = handleEvent(event);

    const params = {
      TableName: table,
      Key: {
        employeeId: parseInt(eventInfo.data.employeeId, 10),
      },
      UpdateExpression: "set #a = :x, #b = :d",
      ExpressionAttributeNames: {
        "#a": "done",
        "#b": "updated_at",
      },
      ExpressionAttributeValues: {
        ":x": eventInfo.data.done,
        ":d": new Date().toISOString(),
      },
    };

    await dynamo.update(params).promise();

    return response(
      200,
      `Record ${eventInfo.data.employeeId} has been updated`
    );
  } catch (err) {
    return response(500, "Somenthing went wrong");
  }
};
