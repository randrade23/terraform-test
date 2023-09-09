import { Router } from 'express'

const router = Router()

router.get('/', (req, res) => {
  res.send({ oi: "gato" })
})

export default router
