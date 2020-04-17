const Yup = require('yup');
const Beacon = require('../models/Beacon');

class BeaconController {
  // METODO PARA CRIAÇÃO DE UM NOVO BEACON (ID, NOME, TIPO DO CONTEUDO(IMAGEM, FOTO, TEXTO OU UM ESPAÇO EM BRANCO), LEGENDA E CONTEUDO(LINK))
  async store(req, res) {
    const schema = Yup.object().shape({
      id: Yup.string().required(),
      content_name: Yup.string().required(),
      content_type: Yup.string()
        .matches(/(texto|imagem|video|)/)
        .required(),
      content: Yup.string().required(),
      content_description: Yup.string().required().max(256),
    });

    if (!(await schema.isValid(req.body))) {
      return res.status(400).json({ error: 'validation fails' });
    }

    const beaconExists = await Beacon.findOne({
      where: { id: req.body.id },
    });
    if (beaconExists) {
      return res.status(400).json({ error: 'Beacon already exists.' });
    }

    const {
      id,
      content_name,
      content_description,
      content,
      content_type,
    } = await Beacon.create(req.body);

    return res.json({
      id,
      content,
      content_description,
      content_name,
      content_type,
    });
  }

  // LISTAGEM DE BEACONS

  async index(req, res) {
    const beacon = await Beacon.findAll({
      attributes: [
        'id',
        'content_name',
        'content_description',
        'content',
        'content_type',
      ],
    });

    return res.json(beacon);
  }

  // LISTAGEM DE BEACONS POR ID
  async indexById(req, res) {
    const beacon = await Beacon.findByPk(req.params.id, {
      attributes: [
        'id',
        'content_name',
        'content_description',
        'content',
        'content_type',
      ],
    });

    return res.json(beacon);
  }

  // ATUALIZAÇÃO DE BEACONS
  async update(req, res) {
    const schema = Yup.object().shape({
      id: Yup.string(),
      content_name: Yup.string(),
      content_type: Yup.string().matches(/(texto|imagem|video|)/),
      content: Yup.string(),
      content_description: Yup.string().max(256),
    });

    if (!(await schema.isValid(req.body))) {
      return res.status(400).json({ error: 'validation fails' });
    }

    const beacon = await Beacon.findByPk(req.params.id);

    if (!beacon) {
      return res.status(500).json({ error: 'Beacon do not exists' });
    }

    const {
      id,
      content_name,
      content_description,
      content,
      content_type,
    } = await beacon.update(req.body);

    return res.json({
      id,
      content,
      content_description,
      content_name,
      content_type,
    });
  }

  // DELETAR BEACON
  async delete(req, res) {
    const beacon = await Beacon.destroy({
      where: { id: req.params.id },
    });

    if (!beacon) {
      return res.status(500).json({ error: 'Beacon do not exists' });
    }

    return res.status(200).json('Beacon Deleted');
  }
}

module.exports = new BeaconController();
