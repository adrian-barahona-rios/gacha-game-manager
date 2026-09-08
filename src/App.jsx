import { Route, Routes } from 'react-router-dom'
import AdminGuard from './components/AdminGuard'
import AdminPanel from './components/AdminPanel'
import CharacterDetail from './components/CharacterDetail'
import CharacterGrid from './components/CharacterGrid'
import CharacterGuides from './components/CharacterGuides'
import GuideDetail from './components/GuideDetail'
import GuideForm from './components/GuideForm'
import MyGuides from './components/MyGuides'
import Dashboard from './components/Dashboard'
import FriendProfile from './components/FriendProfile'
import FriendsMenu from './components/FriendsMenu'
import GamePage from './components/GamePage'
import Login from './components/Login'
import Register from './components/Register'
import TierListOfficial from './components/TierListOfficial'
import TierListPersonal from './components/TierListPersonal'
import UmamusumeCharacters from './components/UmamusumeCharacters'
import UmamusumePage from './components/UmamusumePage'
import UmamusumeSupportCards from './components/UmamusumeSupportCards'
import UmamusumeSupportTierList from './components/UmamusumeSupportTierList'
import ResetPassword from './components/ResetPassword'
import UserProfile from './components/UserProfile'

function App() {
  return (
    <Routes>
      <Route path="/" element={<Login />} />
      <Route path="/login" element={<Login />} />
      <Route path="/register" element={<Register />} />
      <Route path="/dashboard" element={<Dashboard />} />
      <Route path="/game/umamusume" element={<UmamusumePage />} />
      <Route
        path="/game/umamusume/:version/characters"
        element={<UmamusumeCharacters />}
      />
      <Route
        path="/game/umamusume/:version/support-cards"
        element={<UmamusumeSupportCards />}
      />
      <Route
        path="/game/umamusume/:version/tierlist-support"
        element={<UmamusumeSupportTierList />}
      />
      <Route path="/game/:gameId" element={<GamePage />} />
      <Route path="/game/:gameId/characters" element={<CharacterGrid />} />
      <Route
        path="/game/:gameId/characters/:characterId"
        element={<CharacterDetail />}
      />
      <Route
        path="/game/:gameId/characters/:characterId/guides"
        element={<CharacterGuides />}
      />
      <Route
        path="/game/:gameId/tierlist/official"
        element={<TierListOfficial />}
      />
      <Route
        path="/game/:gameId/tierlist/personal"
        element={<TierListPersonal />}
      />
      <Route path="/profile" element={<UserProfile />} />
      <Route path="/profile/my-guides" element={<MyGuides />} />
      <Route path="/profile/my-guides/new" element={<GuideForm />} />
      <Route path="/profile/my-guides/:guideId" element={<GuideDetail />} />
      <Route path="/profile/my-guides/:guideId/edit" element={<GuideForm />} />
      <Route path="/profile/friends" element={<FriendsMenu />} />
      <Route path="/profile/friends/:friendId" element={<FriendProfile />} />
      <Route path="/reset-password" element={<ResetPassword />} />
      {/* Sin enlaces en la interfaz: solo se llega escribiendo la direccion. */}
      <Route
        path="/admin"
        element={
          <AdminGuard>
            <AdminPanel />
          </AdminGuard>
        }
      />
    </Routes>
  )
}

export default App
