import express from 'express'
import helloWorldRoutes from './routes/helloWorld'

const router = express.Router()

// this is a global route
router.get('/health', function(req, res) {
  res.sendStatus(200)
})

router.use('/', helloWorldRoutes)

export default router
