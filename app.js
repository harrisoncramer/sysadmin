const { exec } = require("child_process");
const logger = require("./logger");
const cron = require("node-cron");

logger.info("System booting up...")

cron.schedule('* */12 * * *', async () => {

  logger.info("Running checks...");
  
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