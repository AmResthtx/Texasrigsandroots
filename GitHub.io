import React, { useState } from "react";
import "./App.css";

// Dummy chatbot (replace with a real one in production, e.g. Tawk.to, Drift, Crisp, etc.)
function Chatbot({ onClose }) {
  const [input, setInput] = useState("");
  const [messages, setMessages] = useState([
    { from: "bot", text: "Hi! How can we help you today? Leave your message and we'll get back to you soon." }
  ]);

  const handleSend = () => {
    if (!input.trim()) return;
    setMessages([...messages, { from: "user", text: input }]);
    setMessages(msgs => [
      ...msgs,
      { from: "bot", text: "Thanks! Our team will reach out to you soon." }
    ]);
    setInput("");
  };

  return (
    <div className="chatbot">
      <div className="chatbot-header">
        <span>Texas Rigs & Roots Chat</span>
        <button onClick={onClose}>&times;</button>
      </div>
      <div className="chatbot-messages">
        {messages.map((msg, i) => (
          <div key={i} className={`chatbot-msg ${msg.from}`}>{msg.text}</div>
        ))}
      </div>
      <div className="chatbot-input">
        <input
          placeholder="Type your message..."
          value={input}
          onChange={e => setInput(e.target.value)}
          onKeyDown={e => (e.key === "Enter" ? handleSend() : null)}
        />
        <button onClick={handleSend}>Send</button>
      </div>
    </div>
  );
}

function App() {
  const [showChat, setShowChat] = useState(false);

  // Sharing logic
  const handleShare = async () => {
    const shareData = {
      title: "Texas Rigs and Roots LLC",
      text: "Check out Texas Rigs and Roots LLC for all your helical pier needs!",
      url: window.location.href
    };
    if (navigator.share) {
      await navigator.share(shareData);
      alert("Thanks for sharing! Use code SHARE25 for your promotional price.");
    } else {
      // fallback for copy-paste
      navigator.clipboard.writeText(window.location.href);
      alert("Link copied! Share it with your friends and use code SHARE25 for your promotional price.");
    }
  };

  return (
    <div className="container">
      <header>
        <h1>Texas Rigs and Roots LLC</h1>
        <p>Your Trusted Helical Pier Manufacturer & Installer</p>
      </header>

      <button
        className="call-now"
        onClick={() => window.open("tel:YOUR_PHONE_NUMBER")}
      >
        📞 Call Now
      </button>

      <main>
        <section>
          <h2>About Us</h2>
          <p>
            At Texas Rigs and Roots LLC, we manufacture and install high-quality helical piers for both commercial and residential projects. Our experienced team delivers reliable foundation solutions across Texas.
          </p>
        </section>

        <section>
          <h2>Why Choose Us?</h2>
          <ul>
            <li>Industry-leading expertise and equipment</li>
            <li>Fast, professional installation</li>
            <li>Locally owned and operated</li>
            <li>Free estimates and site assessments</li>
          </ul>
        </section>

        <section className="promo">
          <h2>Special Offer</h2>
          <p>
            <strong>Share our website</strong> on social media or by email and get a <span className="promo-code">promotional price</span>! Click below to share:
          </p>
          <button className="share-btn" onClick={handleShare}>
            Share & Unlock Promo
          </button>
          <p><small>Use code <b>SHARE25</b> when you call or message us!</small></p>
        </section>
      </main>

      <footer>
        <p>
          &copy; {new Date().getFullYear()} Texas Rigs and Roots LLC. All rights reserved.
        </p>
      </footer>

      <button className="chatbot-toggle" onClick={() => setShowChat(s => !s)}>
        💬 {showChat ? "Close Chat" : "Chat with Us"}
      </button>
      {showChat && <Chatbot onClose={() => setShowChat(false)} />}
    </div>
  );
}

export default App;
