const fs = require('fs');
const csv = require('csv-parser');
const { sequelize } = require('./models/Account.js'); // Import your Sequelize instance and models here
const bcrypt = require('bcrypt');

async function importCSV(filePath) {
  try {
    await sequelize.sync(); // Sync the database models

    fs.createReadStream(filePath)
      .pipe(csv())
      .on('data', async (row) => {
        // Check if the user already exists by username
        const existingUser = await sequelize.models.Account.findOne({
          where: { email: row.email }
        });

        if (!existingUser) {
          // Create a new user if not exists
          const hashedPassword = await bcrypt.hash(row.password, 10);
          await sequelize.models.Account.create({
            ...row,
            password: hashedPassword
          });
        }
      })
      .on('end', () => {
        console.log('CSV import completed.');
      });
  } catch (error) {
    console.log('Error importing CSV');
  }
}

module.exports = importCSV;
