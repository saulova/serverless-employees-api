const AWS = require("aws-sdk");
const dynamo = new AWS.DynamoDB.DocumentClient();

const handleEvent = require("/opt/nodejs/handleEvent");
const handleResponse = require("/opt/nodejs/handleResponse");

exports.handler = async (event) => {
  try {
    const table = "employees";
    const eventInfo = handleEvent(event);

    const params = {
      TableName: table,
      Item: {
        ...eventInfo.data,
        created_at: new Date().toISOString(),
      },
    };

    await dynamo.put(params).promise();

    return handleResponse(
      201,
      `Record ${eventInfo.data.employeeId} has been created`
    );
  } catch (err) {
    return handleResponse(500, "Somenthing went wrong");
  }
};
