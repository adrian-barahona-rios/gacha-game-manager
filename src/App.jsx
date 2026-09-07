import { Route, Routes } from 'react-router-dom'
import Dashboard from './components/Dashboard'
import GamePage from './components/GamePage'
import Login from './components/Login'
import Register from './components/Register'
import ResetPassword from './components/ResetPassword'
import UserProfile from './components/UserProfile'

function App() {
  return (
    <Routes>
      <Route path="/" element={<Login />} />
      <Route path="/login" element={<Login />} />
      <Route path="/register" element={<Register />} />
      <Route path="/dashboard" element={<Dashboard />} />
      <Route path="/game/:gameId" element={<GamePage />} />
      <Route path="/profile" element={<UserProfile />} />
      <Route path="/reset-password" element={<ResetPassword />} />
    </Routes>
  )
}

export default App
