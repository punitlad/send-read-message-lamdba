exports.handler = async function(event, context) {
  console.log("Triggered based on sqs message")
  event.Records.forEach(record => {
    const { body } = record;
    console.log(body);
  });
  return {};
}
