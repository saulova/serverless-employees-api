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
    };

    let data = {};
    if (eventInfo.pathParameters && eventInfo.pathParameters["employeeId"]) {
      data = await dynamo
        .get({
          ...params,
          Key: {
            employeeId: parseInt(eventInfo.pathParameters["employeeId"], 10),
          },
        })
        .promise();
    } else {
      data = await dynamo.scan(params).promise();
    }

    return handleResponse(200, data);
  } catch (err) {
    return handleResponse(500, "Somenthing went wrong");
  }
};
