const { Model } = require('sequelize');
const Sequelize = require('sequelize');

class Guest extends Model {
  static init(sequelize) {
    super.init(
      {
        phone_id: {
          type: Sequelize.STRING,
          primaryKey: true,
        },
        name: Sequelize.STRING,
        email: Sequelize.STRING,
      },
      {
        sequelize,
      }
    );
    return this;
  }

  static associate(models) {
    this.belongsTo(models.Dates, { foreignKey: 'phone_id', as: 'date' });
  }
}

module.exports = Guest;
