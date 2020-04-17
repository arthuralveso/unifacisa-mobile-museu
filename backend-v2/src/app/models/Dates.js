const { Model } = require('sequelize');
const Sequelize = require('sequelize');

class Dates extends Model {
  static init(sequelize) {
    super.init(
      {
        date: Sequelize.DATE,
      },
      {
        sequelize,
      }
    );
    return this;
  }

  static associate(models) {
    this.belongsTo(models.Guest, { foreignKey: 'guest_id', as: 'guest' });
  }
}

module.exports = Dates;
