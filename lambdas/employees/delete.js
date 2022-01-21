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
      Key: {
        employeeId: parseInt(eventInfo.data.employeeId, 10),
      },
    };

    await dynamo.delete(params).promise();

    return handleResponse(
      200,
      `Record ${eventInfo.data.employeeId} has been deleted`
    );
  } catch (err) {
    return handleResponse(500, "Somenthing went wrong");
  }
};
