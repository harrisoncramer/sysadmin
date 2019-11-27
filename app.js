const { exec } = require("child_process");
const logger = require("./logger");
const cron = require("node-cron");

cron.schedule('* */12 * * *', async () => {

  exec("./getStats.sh", (err, stdout, stderr) => {
    if (err) {
      logger.error("SysAdmin Error: ", err);
      return;
    }
    if (stderr){
        logger.error("SysAdmin Error (STD): ", stderr);
        return;
    }
  
    logger.info(`System update on ${moment().format(llll)} :`, stdout);
  
  });
  
});