const Yup = require('yup');
const Dates = require('../models/Dates');
const Guest = require('../models/Guest');

class GuestSessionController {
  /** METODO PARA LOGIN DE VISITANTE. QUANDO O VISITANTE FIZER LOGIN,
  ENVIARÁ O ID DO CELULAR PARA PARA QUE O BACKEND CADASTRE O HORARIO DO LOGIN
  * */

  async store(req, res) {
    const schema = Yup.object().shape({
      guest_id: Yup.string().required(),
    });

    const date = new Date();

    if (!(await schema.isValid(req.body))) {
      return res.status(400).json({ error: 'Validation Fails' });
    }

    const { guest_id } = req.body;

    const guestExists = await Guest.findOne({
      where: { phone_id: guest_id },
    });

    if (!guestExists) {
      res.status(500).json({ error: 'Guest do not exists' });
    }

    const dates = await Dates.create({
      guest_id,
      date,
    });

    return res.json(dates);
  }

  // LISTAGEM DAS DATAS DE LOGIN E OS RESPECTIVOS VISITANTES QUE LOGARAM NAQUELE MOMENTO(ID, NOME E EMAIL)
  async index(req, res) {
    const dates = await Dates.findAll({
      attributes: ['date', 'guest_id'],
      include: [
        {
          model: Guest,
          as: 'guest',
          attributes: ['name', 'email'],
        },
      ],
    });
    return res.json(dates);
  }
}

module.exports = new GuestSessionController();
