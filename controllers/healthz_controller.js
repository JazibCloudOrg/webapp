const sequelize = require('../connection');
const { logger } = require('../logger.js');
const sdc = require('../sdc.js');

const healthCheckMiddleware = (req, res, next) => {
    if (req.method !== 'GET') {
      res.status(405).json();
      return;
    }
    if (Object.keys(req.body).length > 0 || Object.keys(req.query).length > 0) {
      sdc.increment("healthz.get");
      logger.error("Payload not allowed for GET request");
      return res.status(400).json({ message: 'Request body not allowed' });
    }
    next();
};  

const gethealthCheckController = async (req, res) => {
    sdc.increment("healthz.get");
    if (Object.keys(req.body).length > 0 || Object.keys(req.query).length > 0) {
      logger.error("Payload not allowed for GET request");
      return res.status(400).json({ message: 'Request body not allowed' });
    }
    if (req.params.id !== undefined) {
      logger.error("Query params not allowed for GET request");
      return res.status(404).json();
    }
    try {
        await sequelize.authenticate();
        logger.info("Health API is working");
        res.set('cache-control', 'no-cache');
        res.status(200).json();
      } catch (error) {
        logger.error("Database service is not available" + error);
        res.status(503).json();
      }
};

module.exports = {
    gethealthCheckController,
    healthCheckMiddleware
}