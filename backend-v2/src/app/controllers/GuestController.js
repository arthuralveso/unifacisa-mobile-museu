const Yup = require('yup');
const Guest = require('../models/Guest');

class GuestController {
  // METODO PARA CRIAÇÃO DE UM NOVO VISITANTE (ID DO CELULAR, NOME, EMAIL)

  async store(req, res) {
    const schema = Yup.object().shape({
      phone_id: Yup.string().required(),
      name: Yup.string().required(),
      email: Yup.string().email().required(),
    });

    if (!(await schema.isValid(req.body))) {
      return res.status(400).json({ error: 'validation fails' });
    }

    const guestExists = await Guest.findOne({
      where: { phone_id: req.body.phone_id },
    });

    if (guestExists) {
      return res.status(400).json({ error: 'Guest already exists.' });
    }

    const { phone_id, name, email } = await Guest.create(req.body);

    return res.json({
      phone_id,
      name,
      email,
    });
  }

  // LISTAGEM DE VISITANTES
  async index(req, res) {
    const guest = await Guest.findAll({
      attributes: ['phone_id', 'name', 'email'],
    });

    return res.json(guest);
  }

  // LISTA DE VISITANTE POR ID DO CELULAR
  async indexById(req, res) {
    const guest = await Guest.findByPk(req.params.id, {
      attributes: ['phone_id', 'name', 'email'],
    });

    return res.json(guest);
  }

  // ATUALIZAR VISITANTE
  async update(req, res) {
    const schema = Yup.object().shape({
      phone_id: Yup.string(),
      name: Yup.string(),
      email: Yup.string().email(),
    });

    if (!(await schema.isValid(req.body))) {
      return res.status(400).json({ error: 'validation fails' });
    }

    const guest = await Guest.findByPk(req.params.id);

    const { name, email } = await guest.update(req.body);

    return res.json({
      name,
      email,
    });
  }

  // DELETAR VISITANTE
  async delete(req, res) {
    const guest = await Guest.destroy({
      where: { id: req.params.id },
    });

    if (!guest) {
      return res.status(500).json({ error: 'User do not exists' });
    }

    return res.status(200).json('User Deleted');
  }
}

module.exports = new GuestController();
