import { useState } from "react";

const scripts = {
  SAB: [
    {
      name: "Freeze Trade",
      desc: "Freeze all active trades in Steal a Brainrot",
      icon: "❄️",
      color: "#00cfff",
      code: `-- SAB Freeze Trade\nloadstring(game:HttpGet('https://raw.githubusercontent.com/example/sab/freeze.lua'))()`,
    },
    {
      name: "Spawner",
      desc: "Spawn any brainrot item instantly",
      icon: "🧠",
      color: "#a855f7",
      code: `-- SAB Spawner\nloadstring(game:HttpGet('https://raw.githubusercontent.com/example/sab/spawner.lua'))()`,
    },
    {
      name: "A/P Gifter",
      desc: "Auto-gift items to any player",
      icon: "🎁",
      color: "#f59e0b",
      code: `-- SAB A/P Gifter\nloadstring(game:HttpGet('https://raw.githubusercontent.com/example/sab/gifter.lua'))()`,
    },
  ],
  ADM: [
    {
      name: "House Cloner",
      desc: "Clone any house model in ADM",
      icon: "🏠",
      color: "#22c55e",
      code: `-- ADM House Cloner\nloadstring(game:HttpGet('https://raw.githubusercontent.com/example/adm/housecloner.lua'))()`,
    },
    {
      name: "Spawner",
      desc: "Spawn ADM items on demand",
      icon: "⚡",
      color: "#f97316",
      code: `-- ADM Spawner\nloadstring(game:HttpGet('https://raw.githubusercontent.com/example/adm/spawner.lua'))()`,
    },
    {
      name: "Freeze Trader",
      desc: "Lock trade windows in ADM",
      icon: "🧊",
      color: "#38bdf8",
      code: `-- ADM Freeze Trader\nloadstring(game:HttpGet('https://raw.githubusercontent.com/example/adm/freezetrade.lua'))()`,
    },
  ],
};

const gameColors = {
  SAB: { from: "#7c3aed", to: "#06b6d4", accent: "#a855f7" },
  ADM: { from: "#065f46", to: "#0284c7", accent: "#22c55e" },
};

const STAGES = ["idle", "injecting", "success"];

function ExecuteButton({ color, onExecute }) {
  const [stage, setStage] = useState("idle");
  const [progress, setProgress] = useState(0);

  const handleClick = () => {
    if (stage !== "idle") return;
    setStage("injecting");
    setProgress(0);

    let p = 0;
    const interval = setInterval(() => {
      p += Math.random() * 18 + 5;
      if (p >= 100) {
        p = 100;
        clearInterval(interval);
        setProgress(100);
        setTimeout(() => {
          setStage("success");
          onExecute && onExecute();
          setTimeout(() => {
            setStage("idle");
            setProgress(0);
          }, 2200);
        }, 200);
      }
      setProgress(p);
    }, 80);
  };

  return (
    <div style={{ position: "relative", display: "inline-block" }}>
      <button
        onClick={handleClick}
        style={{
          position: "relative",
          padding: "7px 16px",
          borderRadius: 8,
          border: "none",
          cursor: stage === "idle" ? "pointer" : "default",
          fontWeight: 700,
          fontSize: 12,
          overflow: "hidden",
          minWidth: 90,
          transition: "box-shadow 0.3s",
          background:
            stage === "success"
              ? "linear-gradient(135deg, #22c55e, #16a34a)"
              : stage === "injecting"
              ? "#1a1a2e"
              : `linear-gradient(135deg, ${color}, ${color}bb)`,
          color: "#fff",
          boxShadow:
            stage === "success"
              ? "0 0 20px #22c55e99, 0 0 40px #22c55e55"
              : stage === "injecting"
              ? `0 0 10px ${color}40`
              : `0 0 14px ${color}50`,
        }}
      >
        {/* Progress bar fill */}
        {stage === "injecting" && (
          <div
            style={{
              position: "absolute",
              left: 0, top: 0, bottom: 0,
              width: `${progress}%`,
              background: `linear-gradient(90deg, ${color}60, ${color}cc)`,
              transition: "width 0.08s linear",
              zIndex: 0,
            }}
          />
        )}

        {/* Label */}
        <span style={{ position: "relative", zIndex: 1, display: "flex", alignItems: "center", gap: 5, justifyContent: "center" }}>
          {stage === "idle" && "Execute"}
          {stage === "injecting" && (
            <>
              <span style={{ display: "inline-block", animation: "spin 0.6s linear infinite" }}>⟳</span>
              {Math.floor(progress)}%
            </>
          )}
          {stage === "success" && (
            <>
              <span style={{ animation: "popIn 0.3s cubic-bezier(0.175,0.885,0.32,1.275)" }}>✓</span>
              Injected!
            </>
          )}
        </span>
      </button>

      {/* Success burst rings */}
      {stage === "success" && (
        <>
          <div style={{
            position: "absolute", inset: 0, borderRadius: 8,
            border: "2px solid #22c55e",
            animation: "ringOut 0.6s ease-out forwards",
            pointerEvents: "none",
          }} />
          <div style={{
            position: "absolute", inset: 0, borderRadius: 8,
            border: "2px solid #22c55e",
            animation: "ringOut 0.6s ease-out 0.15s forwards",
            pointerEvents: "none",
          }} />
        </>
      )}

      <style>{`
        @keyframes spin { to { transform: rotate(360deg); } }
        @keyframes popIn {
          0% { transform: scale(0); opacity: 0; }
          100% { transform: scale(1); opacity: 1; }
        }
        @keyframes ringOut {
          0% { transform: scale(1); opacity: 0.8; }
          100% { transform: scale(1.8); opacity: 0; }
        }
      `}</style>
    </div>
  );
}

export default function UniversalHub() {
  const [activeGame, setActiveGame] = useState("SAB");
  const [copied, setCopied] = useState(null);
  const [toast, setToast] = useState(null);

  const handleCopy = (code, idx) => {
    navigator.clipboard.writeText(code);
    setCopied(idx);
    setTimeout(() => setCopied(null), 1500);
  };

  const showToast = (name) => {
    setToast(name);
    setTimeout(() => setToast(null), 2500);
  };

  const gc = gameColors[activeGame];

  return (
    <div style={{
      minHeight: "100vh",
      background: "#0a0a0f",
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
      fontFamily: "'Segoe UI', sans-serif",
      padding: "20px",
    }}>
      {/* Ambient glow */}
      <div style={{
        position: "fixed", top: 0, left: 0, right: 0, bottom: 0,
        background: `radial-gradient(ellipse at 30% 20%, ${gc.from}22 0%, transparent 60%), radial-gradient(ellipse at 70% 80%, ${gc.to}18 0%, transparent 60%)`,
        pointerEvents: "none", transition: "background 0.6s ease",
      }} />

      {/* Toast notification */}
      <div style={{
        position: "fixed", top: 24, left: "50%", transform: `translateX(-50%) translateY(${toast ? 0 : -80}px)`,
        background: "linear-gradient(135deg, #14532d, #166534)",
        border: "1px solid #22c55e60",
        borderRadius: 12,
        padding: "12px 22px",
        color: "#fff",
        fontWeight: 700,
        fontSize: 14,
        boxShadow: "0 0 30px #22c55e50, 0 8px 32px rgba(0,0,0,0.5)",
        transition: "transform 0.4s cubic-bezier(0.175,0.885,0.32,1.275)",
        zIndex: 999,
        display: "flex", alignItems: "center", gap: 8,
        whiteSpace: "nowrap",
      }}>
        <span style={{ fontSize: 16 }}>✅</span>
        <span>{toast} — <span style={{ color: "#4ade80" }}>Successfully Injected!</span></span>
      </div>

      <div style={{
        width: "100%", maxWidth: 560,
        background: "rgba(15,15,25,0.95)",
        border: `1px solid ${gc.accent}40`,
        borderRadius: 20,
        boxShadow: `0 0 60px ${gc.from}30, 0 0 120px ${gc.to}15, inset 0 1px 0 rgba(255,255,255,0.05)`,
        overflow: "hidden",
        position: "relative",
        transition: "border-color 0.5s, box-shadow 0.5s",
      }}>
        {/* Header */}
        <div style={{
          padding: "24px 28px 18px",
          borderBottom: `1px solid rgba(255,255,255,0.06)`,
          background: "rgba(255,255,255,0.02)",
        }}>
          <div style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: 4 }}>
            <div style={{
              width: 10, height: 10, borderRadius: "50%",
              background: `linear-gradient(135deg, ${gc.from}, ${gc.to})`,
              boxShadow: `0 0 12px ${gc.accent}`,
              animation: "pulse 2s infinite",
            }} />
            <span style={{ color: "rgba(255,255,255,0.3)", fontSize: 11, letterSpacing: 3, textTransform: "uppercase" }}>
              Universal Hub
            </span>
          </div>
          <h1 style={{
            margin: 0, fontSize: 26, fontWeight: 800, letterSpacing: -0.5,
            background: `linear-gradient(135deg, #fff 30%, ${gc.accent})`,
            WebkitBackgroundClip: "text", WebkitTextFillColor: "transparent",
          }}>
            Script Executor
          </h1>
          <p style={{ margin: "4px 0 0", color: "rgba(255,255,255,0.35)", fontSize: 13 }}>
            Select a game and inject your script
          </p>
        </div>

        {/* Game Tabs */}
        <div style={{ display: "flex", padding: "16px 28px 0" }}>
          {Object.keys(scripts).map((game) => {
            const active = activeGame === game;
            const gclr = gameColors[game];
            return (
              <button
                key={game}
                onClick={() => setActiveGame(game)}
                style={{
                  flex: 1, padding: "10px 0", border: "none", cursor: "pointer",
                  borderRadius: "10px 10px 0 0",
                  background: active
                    ? `linear-gradient(180deg, ${gclr.from}30, ${gclr.to}15)`
                    : "transparent",
                  borderBottom: active ? `2px solid ${gclr.accent}` : "2px solid transparent",
                  color: active ? "#fff" : "rgba(255,255,255,0.3)",
                  fontWeight: active ? 700 : 500,
                  fontSize: 14, letterSpacing: 1,
                  transition: "all 0.2s",
                }}>
                {game}
              </button>
            );
          })}
        </div>

        <div style={{ height: 1, background: "rgba(255,255,255,0.06)", margin: "0 28px" }} />

        {/* Script Cards */}
        <div style={{ padding: "20px 28px 28px", display: "flex", flexDirection: "column", gap: 12 }}>
          {scripts[activeGame].map((script, idx) => (
            <div key={`${activeGame}-${idx}`} style={{
              background: "rgba(255,255,255,0.03)",
              border: `1px solid ${script.color}25`,
              borderRadius: 14,
              padding: "16px 18px",
              display: "flex", alignItems: "center", gap: 14,
              transition: "all 0.2s",
              position: "relative",
              overflow: "hidden",
            }}
              onMouseEnter={e => e.currentTarget.style.background = `${script.color}10`}
              onMouseLeave={e => e.currentTarget.style.background = "rgba(255,255,255,0.03)"}
            >
              <div style={{
                position: "absolute", left: 0, top: 0, bottom: 0, width: 3,
                background: `linear-gradient(180deg, ${script.color}, ${script.color}40)`,
                borderRadius: "0 2px 2px 0",
              }} />

              <div style={{
                width: 42, height: 42, borderRadius: 12, flexShrink: 0,
                background: `${script.color}18`,
                border: `1px solid ${script.color}35`,
                display: "flex", alignItems: "center", justifyContent: "center",
                fontSize: 20,
              }}>
                {script.icon}
              </div>

              <div style={{ flex: 1, minWidth: 0 }}>
                <div style={{ color: "#fff", fontWeight: 700, fontSize: 15, marginBottom: 2 }}>
                  {activeGame} {script.name}
                </div>
                <div style={{ color: "rgba(255,255,255,0.38)", fontSize: 12 }}>{script.desc}</div>
              </div>

              <div style={{ display: "flex", gap: 7, flexShrink: 0 }}>
                <button
                  onClick={() => handleCopy(script.code, idx)}
                  style={{
                    padding: "7px 13px", borderRadius: 8, border: `1px solid ${script.color}40`,
                    background: copied === idx ? `${script.color}30` : "rgba(255,255,255,0.04)",
                    color: copied === idx ? script.color : "rgba(255,255,255,0.6)",
                    fontSize: 12, fontWeight: 600, cursor: "pointer", transition: "all 0.2s",
                  }}>
                  {copied === idx ? "✓ Copied" : "Copy"}
                </button>

                <ExecuteButton
                  color={script.color}
                  onExecute={() => showToast(`${activeGame} ${script.name}`)}
                />
              </div>
            </div>
          ))}
        </div>

        {/* Footer */}
        <div style={{
          padding: "12px 28px 18px",
          borderTop: "1px solid rgba(255,255,255,0.05)",
          display: "flex", justifyContent: "space-between", alignItems: "center",
        }}>
          <span style={{ color: "rgba(255,255,255,0.2)", fontSize: 11 }}>
            {scripts[activeGame].length} scripts available
          </span>
          <div style={{ display: "flex", alignItems: "center", gap: 5, color: "rgba(255,255,255,0.2)", fontSize: 11 }}>
            <div style={{
              width: 6, height: 6, borderRadius: "50%", background: "#22c55e",
              boxShadow: "0 0 8px #22c55e",
            }} />
            Hub Online
          </div>
        </div>
      </div>

      <style>{`
        @keyframes pulse {
          0%, 100% { opacity: 1; transform: scale(1); }
          50% { opacity: 0.5; transform: scale(0.85); }
        }
      `}</style>
    </div>
  );
}
