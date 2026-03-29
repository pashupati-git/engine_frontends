<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Engine Mini — Flutter Project</title>
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;500;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;0,600;1,300&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
<style>
  :root {
    --navy: #0D1B2A;
    --navy-mid: #1A2D42;
    --navy-light: #243B55;
    --blue: #2563EB;
    --blue-bright: #3B82F6;
    --blue-glow: rgba(59,130,246,0.15);
    --cyan: #06B6D4;
    --amber: #F59E0B;
    --green: #10B981;
    --red: #EF4444;
    --surface: #111827;
    --surface2: #1F2937;
    --border: rgba(255,255,255,0.07);
    --border-bright: rgba(59,130,246,0.3);
    --text: #F1F5F9;
    --text-muted: #94A3B8;
    --text-dim: #475569;
  }

  * { margin: 0; padding: 0; box-sizing: border-box; }

  html { scroll-behavior: smooth; }

  body {
    background: var(--navy);
    color: var(--text);
    font-family: 'DM Sans', sans-serif;
    font-size: 15px;
    line-height: 1.7;
    overflow-x: hidden;
  }

  /* ── GRID BACKGROUND ── */
  body::before {
    content: '';
    position: fixed;
    inset: 0;
    background-image:
      linear-gradient(rgba(59,130,246,0.03) 1px, transparent 1px),
      linear-gradient(90deg, rgba(59,130,246,0.03) 1px, transparent 1px);
    background-size: 48px 48px;
    pointer-events: none;
    z-index: 0;
  }

  /* ── GLOW ORBS ── */
  .orb {
    position: fixed;
    border-radius: 50%;
    filter: blur(120px);
    pointer-events: none;
    z-index: 0;
  }
  .orb-1 { width: 600px; height: 600px; background: rgba(37,99,235,0.12); top: -200px; right: -200px; }
  .orb-2 { width: 400px; height: 400px; background: rgba(6,182,212,0.07); bottom: 200px; left: -100px; }

  /* ── WRAPPER ── */
  .wrap {
    position: relative;
    z-index: 1;
    max-width: 960px;
    margin: 0 auto;
    padding: 0 32px;
  }

  /* ══════════════════════════════
     HERO
  ══════════════════════════════ */
  .hero {
    padding: 100px 0 80px;
    text-align: center;
    position: relative;
  }

  .hero-badge {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: rgba(37,99,235,0.15);
    border: 1px solid var(--border-bright);
    border-radius: 100px;
    padding: 6px 16px;
    font-family: 'JetBrains Mono', monospace;
    font-size: 11px;
    color: var(--blue-bright);
    letter-spacing: 0.08em;
    margin-bottom: 32px;
    animation: fadeUp 0.6s ease both;
  }

  .hero-badge::before {
    content: '';
    width: 6px; height: 6px;
    background: var(--blue-bright);
    border-radius: 50%;
    animation: pulse 2s infinite;
  }

  @keyframes pulse {
    0%, 100% { opacity: 1; transform: scale(1); }
    50% { opacity: 0.5; transform: scale(0.8); }
  }

  .hero h1 {
    font-family: 'Syne', sans-serif;
    font-size: clamp(52px, 8vw, 86px);
    font-weight: 800;
    line-height: 1.0;
    letter-spacing: -0.03em;
    animation: fadeUp 0.6s 0.1s ease both;
  }

  .hero h1 .accent {
    background: linear-gradient(135deg, var(--blue-bright), var(--cyan));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }

  .hero-sub {
    margin-top: 20px;
    font-size: 17px;
    color: var(--text-muted);
    max-width: 520px;
    margin-left: auto;
    margin-right: auto;
    font-weight: 300;
    animation: fadeUp 0.6s 0.2s ease both;
  }

  .hero-pills {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    justify-content: center;
    margin-top: 36px;
    animation: fadeUp 0.6s 0.3s ease both;
  }

  .pill {
    display: flex;
    align-items: center;
    gap: 6px;
    background: var(--surface2);
    border: 1px solid var(--border);
    border-radius: 8px;
    padding: 6px 14px;
    font-size: 12px;
    font-weight: 500;
    color: var(--text-muted);
    font-family: 'JetBrains Mono', monospace;
  }

  .pill .dot {
    width: 6px; height: 6px;
    border-radius: 50%;
  }

  .hero-divider {
    width: 1px;
    height: 60px;
    background: linear-gradient(to bottom, transparent, var(--border-bright), transparent);
    margin: 48px auto 0;
    animation: fadeUp 0.6s 0.4s ease both;
  }

  @keyframes fadeUp {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
  }

  /* ══════════════════════════════
     SECTION
  ══════════════════════════════ */
  section {
    padding: 64px 0;
    border-top: 1px solid var(--border);
  }

  .section-label {
    display: flex;
    align-items: center;
    gap: 10px;
    font-family: 'JetBrains Mono', monospace;
    font-size: 11px;
    color: var(--blue-bright);
    letter-spacing: 0.12em;
    text-transform: uppercase;
    margin-bottom: 16px;
  }

  .section-label::after {
    content: '';
    flex: 1;
    height: 1px;
    background: var(--border);
  }

  h2 {
    font-family: 'Syne', sans-serif;
    font-size: 32px;
    font-weight: 700;
    letter-spacing: -0.02em;
    margin-bottom: 12px;
  }

  h3 {
    font-family: 'Syne', sans-serif;
    font-size: 18px;
    font-weight: 600;
    margin-bottom: 8px;
  }

  p { color: var(--text-muted); margin-bottom: 16px; }

  /* ══════════════════════════════
     OVERVIEW CARDS
  ══════════════════════════════ */
  .cards-3 {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 16px;
    margin-top: 40px;
  }

  @media (max-width: 680px) { .cards-3 { grid-template-columns: 1fr; } }

  .card {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 16px;
    padding: 24px;
    transition: border-color 0.2s, transform 0.2s;
    position: relative;
    overflow: hidden;
  }

  .card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 2px;
    border-radius: 16px 16px 0 0;
  }

  .card:hover { border-color: var(--border-bright); transform: translateY(-2px); }

  .card.blue::before { background: linear-gradient(90deg, var(--blue), var(--cyan)); }
  .card.amber::before { background: linear-gradient(90deg, var(--amber), #F97316); }
  .card.green::before { background: linear-gradient(90deg, var(--green), #06B6D4); }

  .card-icon {
    width: 40px; height: 40px;
    border-radius: 10px;
    display: flex; align-items: center; justify-content: center;
    font-size: 18px;
    margin-bottom: 14px;
  }
  .card.blue .card-icon { background: rgba(37,99,235,0.15); }
  .card.amber .card-icon { background: rgba(245,158,11,0.15); }
  .card.green .card-icon { background: rgba(16,185,129,0.15); }

  .card h3 { font-size: 15px; margin-bottom: 6px; }
  .card p { font-size: 13px; margin: 0; line-height: 1.6; }

  /* ══════════════════════════════
     FEATURE GRID
  ══════════════════════════════ */
  .features {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 16px;
    margin-top: 40px;
  }

  @media (max-width: 600px) { .features { grid-template-columns: 1fr; } }

  .feature {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 14px;
    padding: 22px;
    display: flex;
    gap: 16px;
    transition: border-color 0.2s;
  }

  .feature:hover { border-color: var(--border-bright); }

  .feature-num {
    font-family: 'JetBrains Mono', monospace;
    font-size: 11px;
    color: var(--text-dim);
    min-width: 28px;
    padding-top: 2px;
  }

  .feature-body h3 { font-size: 14px; margin-bottom: 4px; color: var(--text); }
  .feature-body p { font-size: 12.5px; margin: 0; line-height: 1.55; }

  /* ══════════════════════════════
     PHONE MOCKUP
  ══════════════════════════════ */
  .screens-section {
    text-align: center;
  }

  .screens-showcase {
    display: flex;
    gap: 24px;
    justify-content: center;
    align-items: flex-end;
    margin-top: 48px;
    flex-wrap: wrap;
  }

  .phone {
    width: 200px;
    background: var(--navy-mid);
    border-radius: 36px;
    border: 2px solid rgba(255,255,255,0.1);
    padding: 12px;
    box-shadow: 0 40px 80px rgba(0,0,0,0.5), 0 0 0 1px rgba(255,255,255,0.04);
    position: relative;
    transition: transform 0.3s;
  }

  .phone:hover { transform: translateY(-6px) rotate(-1deg); }
  .phone.center { transform: scale(1.08); z-index: 2; }
  .phone.center:hover { transform: scale(1.08) translateY(-6px); }

  .phone-notch {
    width: 60px; height: 16px;
    background: var(--navy);
    border-radius: 0 0 12px 12px;
    margin: 0 auto 8px;
  }

  .phone-screen {
    background: #F8FAFC;
    border-radius: 24px;
    overflow: hidden;
    min-height: 360px;
  }

  .phone-label {
    margin-top: 16px;
    font-family: 'JetBrains Mono', monospace;
    font-size: 11px;
    color: var(--text-dim);
    letter-spacing: 0.06em;
  }

  /* Simulated screen content */
  .sim-header {
    background: #0D1B2A;
    padding: 10px 12px 12px;
  }

  .sim-isp { font-size: 7px; color: #5B9BD5; font-weight: 600; letter-spacing: 1px; margin-bottom: 2px; font-family: 'DM Sans', sans-serif; }
  .sim-title { font-size: 12px; color: #fff; font-weight: 700; font-family: 'DM Sans', sans-serif; margin-bottom: 1px; }
  .sim-sub { font-size: 7.5px; color: #8BA8C4; font-family: 'DM Sans', sans-serif; }

  .sim-stepbar {
    background: #fff;
    border-bottom: 1px solid #E2E8F0;
    padding: 7px 12px;
  }

  .sim-step-row { display: flex; justify-content: space-between; margin-bottom: 5px; }
  .sim-step-label { font-size: 7px; font-weight: 600; color: #1E293B; font-family: 'DM Sans', sans-serif; }
  .sim-step-count { font-size: 6.5px; color: #94A3B8; font-family: 'DM Sans', sans-serif; }

  .sim-dots { display: flex; gap: 4px; align-items: center; }
  .sim-dot { height: 4px; border-radius: 2px; background: #CBD5E1; }
  .sim-dot.done { background: #93C5FD; width: 4px; }
  .sim-dot.active { background: #2563EB; width: 14px; }
  .sim-dot.idle { width: 4px; }

  .sim-body { background: #F1F5F9; padding: 10px; }

  .sim-section-hdr {
    display: flex;
    align-items: center;
    gap: 5px;
    margin-bottom: 7px;
  }

  .sim-badge {
    background: #0D1B2A;
    color: #fff;
    font-size: 6px;
    font-weight: 700;
    padding: 2px 5px;
    border-radius: 3px;
    font-family: 'DM Sans', sans-serif;
  }

  .sim-badge-title { font-size: 8px; font-weight: 600; color: #1E293B; font-family: 'DM Sans', sans-serif; }
  .sim-line-div { flex: 1; height: 1px; background: #E2E8F0; }

  .sim-card {
    background: #fff;
    border-radius: 10px;
    border: 1px solid #E2E8F0;
    padding: 8px;
    margin-bottom: 6px;
  }

  .sim-field { margin-bottom: 5px; }
  .sim-field-label { font-size: 5.5px; font-weight: 600; color: #94A3B8; text-transform: uppercase; letter-spacing: 0.4px; font-family: 'DM Sans', sans-serif; margin-bottom: 2px; }
  .sim-field-val {
    background: #F1F5F9;
    border: 1px solid #E2E8F0;
    border-radius: 5px;
    padding: 3px 6px;
    font-size: 7px;
    color: #334155;
    font-family: 'DM Sans', sans-serif;
  }

  .sim-field-row { display: flex; gap: 5px; }
  .sim-field-row .sim-field { flex: 1; }

  .sim-check {
    display: flex;
    align-items: center;
    gap: 5px;
    background: #EFF6FF;
    border: 1px solid #2563EB;
    border-radius: 6px;
    padding: 4px 6px;
    margin-bottom: 4px;
  }

  .sim-checkbox {
    width: 10px; height: 10px;
    border-radius: 3px;
    background: #2563EB;
    display: flex; align-items: center; justify-content: center;
    flex-shrink: 0;
  }

  .sim-checkbox-text { font-size: 6.5px; color: #1E293B; font-family: 'DM Sans', sans-serif; }

  .sim-check-idle {
    background: #fff;
    border-color: #E2E8F0;
  }

  .sim-checkbox-idle { background: #fff; border: 1.5px solid #CBD5E1; }

  .sim-star-row {
    display: flex; align-items: center; justify-content: space-between;
    padding: 4px 0;
    border-bottom: 1px solid #F1F5F9;
  }

  .sim-star-label { font-size: 6.5px; color: #334155; font-family: 'DM Sans', sans-serif; }
  .sim-stars { display: flex; gap: 1px; }
  .sim-star { font-size: 8px; color: #CBD5E1; }
  .sim-star.filled { color: #F59E0B; }

  .sim-footer {
    display: flex;
    gap: 5px;
    padding: 8px;
    background: #fff;
    border-top: 1px solid #E2E8F0;
  }

  .sim-btn-back {
    flex: 1;
    border: 1.5px solid #CBD5E1;
    border-radius: 10px;
    padding: 5px;
    text-align: center;
    font-size: 7px;
    font-weight: 600;
    color: #94A3B8;
    font-family: 'DM Sans', sans-serif;
  }

  .sim-btn-next {
    flex: 2;
    background: #0D1B2A;
    border-radius: 10px;
    padding: 5px;
    text-align: center;
    font-size: 7px;
    font-weight: 600;
    color: #fff;
    font-family: 'DM Sans', sans-serif;
  }

  .sim-btn-submit { background: #2563EB; }
  .sim-btn-success { background: #10B981; }

  .sim-sig-area {
    border: 1.5px dashed #CBD5E1;
    border-radius: 6px;
    padding: 12px;
    text-align: center;
    font-size: 7px;
    color: #94A3B8;
    font-family: 'DM Sans', sans-serif;
    margin-bottom: 6px;
  }

  .sim-sig-signed {
    background: #F0FDF4;
    border: 1.5px solid #10B981;
    border-style: solid;
    color: #10B981;
    font-weight: 600;
  }

  /* ══════════════════════════════
     TECH STACK
  ══════════════════════════════ */
  .stack-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 12px;
    margin-top: 36px;
  }

  @media (max-width: 600px) { .stack-grid { grid-template-columns: repeat(2, 1fr); } }

  .stack-item {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 16px;
    text-align: center;
    transition: border-color 0.2s, transform 0.2s;
  }

  .stack-item:hover { border-color: var(--border-bright); transform: translateY(-2px); }

  .stack-emoji { font-size: 24px; margin-bottom: 8px; }
  .stack-name { font-family: 'JetBrains Mono', monospace; font-size: 11px; color: var(--text); font-weight: 500; }
  .stack-desc { font-size: 11px; color: var(--text-dim); margin-top: 2px; }

  /* ══════════════════════════════
     CODE BLOCK
  ══════════════════════════════ */
  .code-wrap {
    background: #0A0F1A;
    border: 1px solid var(--border);
    border-radius: 14px;
    overflow: hidden;
    margin: 24px 0;
  }

  .code-header {
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 12px 16px;
    border-bottom: 1px solid var(--border);
    background: rgba(255,255,255,0.02);
  }

  .code-dot { width: 10px; height: 10px; border-radius: 50%; }
  .code-dot.r { background: #FF5F57; }
  .code-dot.y { background: #FEBC2E; }
  .code-dot.g { background: #28C840; }

  .code-file {
    font-family: 'JetBrains Mono', monospace;
    font-size: 11px;
    color: var(--text-muted);
    margin-left: auto;
  }

  pre {
    padding: 20px;
    overflow-x: auto;
    font-family: 'JetBrains Mono', monospace;
    font-size: 12px;
    line-height: 1.75;
  }

  .k { color: #C678DD; }  /* keyword */
  .s { color: #98C379; }  /* string */
  .c { color: #5C6370; font-style: italic; }  /* comment */
  .f { color: #61AFEF; }  /* function */
  .n { color: #E5C07B; }  /* number/const */
  .t { color: #E06C75; }  /* type */
  .p { color: #ABB2BF; }  /* plain */

  /* ══════════════════════════════
     FLOW DIAGRAM
  ══════════════════════════════ */
  .flow {
    display: flex;
    align-items: center;
    gap: 0;
    flex-wrap: wrap;
    justify-content: center;
    margin: 36px 0;
  }

  .flow-step {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 8px;
    text-align: center;
  }

  .flow-box {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 12px 20px;
    font-size: 12px;
    font-weight: 500;
    color: var(--text);
    white-space: nowrap;
    transition: border-color 0.2s;
  }

  .flow-box:hover { border-color: var(--border-bright); }
  .flow-box.active { border-color: var(--blue-bright); background: var(--blue-glow); color: var(--blue-bright); }

  .flow-num {
    font-family: 'JetBrains Mono', monospace;
    font-size: 10px;
    color: var(--text-dim);
  }

  .flow-arrow {
    color: var(--text-dim);
    font-size: 18px;
    padding: 0 4px;
    margin-bottom: 20px;
  }

  /* ══════════════════════════════
     ERRORS TABLE
  ══════════════════════════════ */
  .errors-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 28px;
    font-size: 13px;
  }

  .errors-table th {
    text-align: left;
    padding: 10px 16px;
    font-family: 'JetBrains Mono', monospace;
    font-size: 10px;
    color: var(--text-dim);
    letter-spacing: 0.08em;
    text-transform: uppercase;
    border-bottom: 1px solid var(--border);
  }

  .errors-table td {
    padding: 12px 16px;
    border-bottom: 1px solid var(--border);
    vertical-align: top;
  }

  .errors-table tr:hover td { background: rgba(255,255,255,0.02); }

  .badge {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    padding: 3px 10px;
    border-radius: 100px;
    font-size: 11px;
    font-weight: 500;
    font-family: 'JetBrains Mono', monospace;
  }

  .badge.fixed { background: rgba(16,185,129,0.12); color: var(--green); border: 1px solid rgba(16,185,129,0.2); }
  .badge.warn { background: rgba(245,158,11,0.12); color: var(--amber); border: 1px solid rgba(245,158,11,0.2); }
  .badge.info { background: rgba(59,130,246,0.12); color: var(--blue-bright); border: 1px solid rgba(59,130,246,0.2); }

  code {
    font-family: 'JetBrains Mono', monospace;
    font-size: 11.5px;
    background: rgba(255,255,255,0.06);
    padding: 2px 6px;
    border-radius: 4px;
    color: #E5C07B;
  }

  /* ══════════════════════════════
     STRUCTURE TREE
  ══════════════════════════════ */
  .tree {
    background: #0A0F1A;
    border: 1px solid var(--border);
    border-radius: 14px;
    padding: 24px;
    margin-top: 28px;
    font-family: 'JetBrains Mono', monospace;
    font-size: 12.5px;
    line-height: 2;
  }

  .tree-folder { color: var(--blue-bright); }
  .tree-file { color: var(--text-muted); }
  .tree-comment { color: var(--text-dim); }
  .tree-indent1 { padding-left: 20px; }
  .tree-indent2 { padding-left: 40px; }
  .tree-indent3 { padding-left: 60px; }

  /* ══════════════════════════════
     SETUP STEPS
  ══════════════════════════════ */
  .setup-steps {
    counter-reset: step;
    margin-top: 32px;
  }

  .setup-step {
    display: flex;
    gap: 20px;
    padding: 24px 0;
    border-bottom: 1px solid var(--border);
    position: relative;
  }

  .setup-step:last-child { border: none; }

  .step-num {
    width: 36px; height: 36px;
    background: var(--surface2);
    border: 1px solid var(--border-bright);
    border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    font-family: 'JetBrains Mono', monospace;
    font-size: 13px;
    color: var(--blue-bright);
    flex-shrink: 0;
    font-weight: 600;
  }

  .step-content h3 { font-size: 15px; margin-bottom: 6px; }
  .step-content p { font-size: 13px; margin: 0 0 10px; }

  /* ══════════════════════════════
     FOOTER
  ══════════════════════════════ */
  footer {
    border-top: 1px solid var(--border);
    padding: 48px 0;
    text-align: center;
  }

  .footer-logo {
    font-family: 'Syne', sans-serif;
    font-size: 22px;
    font-weight: 800;
    letter-spacing: -0.02em;
    margin-bottom: 12px;
  }

  .footer-logo span { color: var(--blue-bright); }

  footer p { font-size: 13px; color: var(--text-dim); margin: 0; }

  .footer-links {
    display: flex;
    gap: 24px;
    justify-content: center;
    margin-top: 20px;
  }

  .footer-links a {
    font-size: 12px;
    color: var(--text-dim);
    text-decoration: none;
    font-family: 'JetBrains Mono', monospace;
    transition: color 0.2s;
  }

  .footer-links a:hover { color: var(--blue-bright); }

  /* ══════════════════════════════
     DIVIDER
  ══════════════════════════════ */
  .divider {
    height: 1px;
    background: linear-gradient(90deg, transparent, var(--border-bright), transparent);
    margin: 16px 0;
  }

  /* ══════════════════════════════
     SCROLL REVEAL
  ══════════════════════════════ */
  .reveal {
    opacity: 0;
    transform: translateY(24px);
    transition: opacity 0.6s ease, transform 0.6s ease;
  }
  .reveal.visible { opacity: 1; transform: translateY(0); }

</style>
</head>
<body>

<div class="orb orb-1"></div>
<div class="orb orb-2"></div>

<!-- ═══════════ HERO ═══════════ -->
<div class="wrap">
  <div class="hero">
    <div class="hero-badge">v0.1.0-preview &nbsp;·&nbsp; Flutter 3.x</div>
    <h1>Engine <span class="accent">Mini</span></h1>
    <p class="hero-sub">A modular Flutter application featuring multi-step form flows, ISP field operations tools, and enterprise-grade UI systems.</p>
    <div class="hero-pills">
      <div class="pill"><div class="dot" style="background:#54C5F8"></div> Flutter</div>
      <div class="pill"><div class="dot" style="background:#F95C5C"></div> Dart</div>
      <div class="pill"><div class="dot" style="background:#A78BFA"></div> ScreenUtil</div>
      <div class="pill"><div class="dot" style="background:#34D399"></div> Google Fonts</div>
      <div class="pill"><div class="dot" style="background:#FBBF24"></div> Android</div>
    </div>
    <div class="hero-divider"></div>
  </div>
</div>

<!-- ═══════════ OVERVIEW ═══════════ -->
<div class="wrap">
  <section class="reveal">
    <div class="section-label">Overview</div>
    <h2>What is Engine Mini?</h2>
    <p>Engine Mini is a prototype Flutter application built for ISP field operations management. It demonstrates two complete feature modules — an RC Rollback customer details workflow and a multi-step Exit Interview form system — both built with a shared design language and responsive component library.</p>

    <div class="cards-3">
      <div class="card blue">
        <div class="card-icon">📋</div>
        <h3>Exit Interview Form</h3>
        <p>5-step guided form with employee info, reason selection, star ratings, open feedback, and digital signature.</p>
      </div>
      <div class="card amber">
        <div class="card-icon">🔄</div>
        <h3>RC Rollback Module</h3>
        <p>Customer details screen for ISP RC rollback operations with read-only data fields and action controls.</p>
      </div>
      <div class="card green">
        <div class="card-icon">🎨</div>
        <h3>Shared Design System</h3>
        <p>Reusable widget library with consistent theming, ScreenUtil-based responsive sizing, and DM Sans typography.</p>
      </div>
    </div>
  </section>
</div>

<!-- ═══════════ SCREENS ═══════════ -->
<div class="wrap">
  <section class="reveal screens-section">
    <div class="section-label">UI Screens</div>
    <h2>Screen Showcase</h2>
    <p>Five connected pages guide the user through a complete exit interview workflow, from employee identification to signed submission.</p>

    <div class="screens-showcase">

      <!-- Phone 1: Employee Info -->
      <div class="phone">
        <div class="phone-notch"></div>
        <div class="phone-screen">
          <div class="sim-header">
            <div class="sim-isp">ISP COMPANY</div>
            <div class="sim-title">Exit Interview Form</div>
            <div class="sim-sub">Field Operations Staff · Confidential</div>
          </div>
          <div class="sim-stepbar">
            <div class="sim-step-row">
              <span class="sim-step-label">Employee Info</span>
              <span class="sim-step-count">1 of 5</span>
            </div>
            <div class="sim-dots">
              <div class="sim-dot active"></div>
              <div class="sim-dot idle"></div>
              <div class="sim-dot idle"></div>
              <div class="sim-dot idle"></div>
              <div class="sim-dot idle"></div>
            </div>
          </div>
          <div class="sim-body">
            <div class="sim-section-hdr">
              <span class="sim-badge">A</span>
              <span class="sim-badge-title">Employee Information</span>
              <span class="sim-line-div"></span>
            </div>
            <div class="sim-card">
              <div class="sim-field-row">
                <div class="sim-field">
                  <div class="sim-field-label">Employee Name</div>
                  <div class="sim-field-val">John Doe</div>
                </div>
                <div class="sim-field">
                  <div class="sim-field-label">Employee ID</div>
                  <div class="sim-field-val">EMP-0042</div>
                </div>
              </div>
              <div style="height:5px"></div>
              <div class="sim-field-row">
                <div class="sim-field">
                  <div class="sim-field-label">Job Title</div>
                  <div class="sim-field-val">Field Tech</div>
                </div>
                <div class="sim-field">
                  <div class="sim-field-label">Department</div>
                  <div class="sim-field-val">Operations</div>
                </div>
              </div>
            </div>
          </div>
          <div class="sim-footer">
            <div class="sim-btn-next">Next →</div>
          </div>
        </div>
        <div class="phone-label">01 / Employee Info</div>
      </div>

      <!-- Phone 2: Reasons (center) -->
      <div class="phone center">
        <div class="phone-notch"></div>
        <div class="phone-screen">
          <div class="sim-header">
            <div class="sim-isp">ISP COMPANY</div>
            <div class="sim-title">Exit Interview Form</div>
            <div class="sim-sub">Field Operations Staff · Confidential</div>
          </div>
          <div class="sim-stepbar">
            <div class="sim-step-row">
              <span class="sim-step-label">Reason for Leaving</span>
              <span class="sim-step-count">2 of 5</span>
            </div>
            <div class="sim-dots">
              <div class="sim-dot done"></div>
              <div class="sim-dot active"></div>
              <div class="sim-dot idle"></div>
              <div class="sim-dot idle"></div>
              <div class="sim-dot idle"></div>
            </div>
          </div>
          <div class="sim-body">
            <div class="sim-section-hdr">
              <span class="sim-badge">B</span>
              <span class="sim-badge-title">Primary Reason</span>
              <span class="sim-line-div"></span>
            </div>
            <div class="sim-card">
              <div class="sim-check">
                <div class="sim-checkbox"><span style="color:#fff;font-size:6px">✓</span></div>
                <span class="sim-checkbox-text">Better Opportunity Elsewhere</span>
              </div>
              <div class="sim-check">
                <div class="sim-checkbox"><span style="color:#fff;font-size:6px">✓</span></div>
                <span class="sim-checkbox-text">Compensation & Benefits</span>
              </div>
              <div class="sim-check sim-check-idle">
                <div class="sim-checkbox sim-checkbox-idle"></div>
                <span class="sim-checkbox-text">Work-Life Balance</span>
              </div>
              <div class="sim-check sim-check-idle">
                <div class="sim-checkbox sim-checkbox-idle"></div>
                <span class="sim-checkbox-text">Relocation</span>
              </div>
            </div>
          </div>
          <div class="sim-footer">
            <div class="sim-btn-back">← Back</div>
            <div class="sim-btn-next">Next →</div>
          </div>
        </div>
        <div class="phone-label">02 / Reasons</div>
      </div>

      <!-- Phone 3: Ratings -->
      <div class="phone">
        <div class="phone-notch"></div>
        <div class="phone-screen">
          <div class="sim-header">
            <div class="sim-isp">ISP COMPANY</div>
            <div class="sim-title">Exit Interview Form</div>
            <div class="sim-sub">Field Operations Staff · Confidential</div>
          </div>
          <div class="sim-stepbar">
            <div class="sim-step-row">
              <span class="sim-step-label">Satisfaction Rating</span>
              <span class="sim-step-count">3 of 5</span>
            </div>
            <div class="sim-dots">
              <div class="sim-dot done"></div>
              <div class="sim-dot done"></div>
              <div class="sim-dot active"></div>
              <div class="sim-dot idle"></div>
              <div class="sim-dot idle"></div>
            </div>
          </div>
          <div class="sim-body">
            <div class="sim-section-hdr">
              <span class="sim-badge">C</span>
              <span class="sim-badge-title">Job Satisfaction</span>
              <span class="sim-line-div"></span>
            </div>
            <div class="sim-card">
              <div class="sim-star-row">
                <span class="sim-star-label">Work Environment</span>
                <div class="sim-stars">
                  <span class="sim-star filled">★</span><span class="sim-star filled">★</span><span class="sim-star filled">★</span><span class="sim-star filled">★</span><span class="sim-star">★</span>
                </div>
              </div>
              <div class="sim-star-row">
                <span class="sim-star-label">Management Support</span>
                <div class="sim-stars">
                  <span class="sim-star filled">★</span><span class="sim-star filled">★</span><span class="sim-star filled">★</span><span class="sim-star">★</span><span class="sim-star">★</span>
                </div>
              </div>
              <div class="sim-star-row">
                <span class="sim-star-label">Compensation</span>
                <div class="sim-stars">
                  <span class="sim-star filled">★</span><span class="sim-star filled">★</span><span class="sim-star">★</span><span class="sim-star">★</span><span class="sim-star">★</span>
                </div>
              </div>
            </div>
          </div>
          <div class="sim-footer">
            <div class="sim-btn-back">← Back</div>
            <div class="sim-btn-next">Next →</div>
          </div>
        </div>
        <div class="phone-label">03 / Ratings</div>
      </div>

    </div>

    <!-- Row 2: Feedback + Signature -->
    <div class="screens-showcase" style="margin-top:20px">

      <!-- Phone 4: Feedback -->
      <div class="phone">
        <div class="phone-notch"></div>
        <div class="phone-screen">
          <div class="sim-header">
            <div class="sim-isp">ISP COMPANY</div>
            <div class="sim-title">Exit Interview Form</div>
            <div class="sim-sub">Field Operations Staff · Confidential</div>
          </div>
          <div class="sim-stepbar">
            <div class="sim-step-row">
              <span class="sim-step-label">Open Feedback</span>
              <span class="sim-step-count">4 of 5</span>
            </div>
            <div class="sim-dots">
              <div class="sim-dot done"></div>
              <div class="sim-dot done"></div>
              <div class="sim-dot done"></div>
              <div class="sim-dot active"></div>
              <div class="sim-dot idle"></div>
            </div>
          </div>
          <div class="sim-body">
            <div class="sim-section-hdr">
              <span class="sim-badge">D</span>
              <span class="sim-badge-title">Open-ended Feedback</span>
              <span class="sim-line-div"></span>
            </div>
            <div class="sim-card">
              <div style="display:flex;align-items:flex-start;gap:5px;margin-bottom:5px">
                <div style="width:14px;height:14px;border-radius:50%;background:#0D1B2A;display:flex;align-items:center;justify-content:center;flex-shrink:0">
                  <span style="font-size:6px;color:#fff;font-weight:700">1</span>
                </div>
                <span style="font-size:6.5px;color:#334155;font-family:'DM Sans',sans-serif">What did you enjoy most about working as field staff?</span>
              </div>
              <div style="background:#F1F5F9;border:1px solid #E2E8F0;border-radius:5px;padding:6px;font-size:6px;color:#94A3B8;font-family:'DM Sans',sans-serif;height:28px">Your response...</div>
            </div>
          </div>
          <div class="sim-footer">
            <div class="sim-btn-back">← Back</div>
            <div class="sim-btn-next">Next →</div>
          </div>
        </div>
        <div class="phone-label">04 / Feedback</div>
      </div>

      <!-- Phone 5: Signature -->
      <div class="phone center">
        <div class="phone-notch"></div>
        <div class="phone-screen">
          <div class="sim-header">
            <div class="sim-isp">ISP COMPANY</div>
            <div class="sim-title">Exit Interview Form</div>
            <div class="sim-sub">Field Operations Staff · Confidential</div>
          </div>
          <div class="sim-stepbar">
            <div class="sim-step-row">
              <span class="sim-step-label">Signature</span>
              <span class="sim-step-count">5 of 5</span>
            </div>
            <div class="sim-dots">
              <div class="sim-dot done"></div>
              <div class="sim-dot done"></div>
              <div class="sim-dot done"></div>
              <div class="sim-dot done"></div>
              <div class="sim-dot active"></div>
            </div>
          </div>
          <div class="sim-body">
            <div class="sim-section-hdr">
              <span class="sim-badge">✏</span>
              <span class="sim-badge-title">Acknowledgement</span>
              <span class="sim-line-div"></span>
            </div>
            <div class="sim-card">
              <div style="font-size:5.5px;font-weight:600;color:#94A3B8;text-transform:uppercase;letter-spacing:0.4px;font-family:'DM Sans',sans-serif;margin-bottom:4px">Employee Signature</div>
              <div class="sim-sig-area sim-sig-signed">✓ &nbsp;Signed</div>
              <div style="background:#F0FDF4;border:1px solid rgba(16,185,129,0.3);border-radius:6px;padding:5px;display:flex;align-items:center;gap:4px">
                <span style="font-size:9px">✅</span>
                <span style="font-size:6px;color:#10B981;font-family:'DM Sans',sans-serif">Signature recorded. Ready to submit.</span>
              </div>
            </div>
          </div>
          <div class="sim-footer">
            <div class="sim-btn-back">← Back</div>
            <div class="sim-btn-next sim-btn-submit">Submit Form</div>
          </div>
        </div>
        <div class="phone-label">05 / Signature</div>
      </div>

    </div>
  </section>
</div>

<!-- ═══════════ FORM FLOW ═══════════ -->
<div class="wrap">
  <section class="reveal">
    <div class="section-label">Architecture</div>
    <h2>Multi-Step Form Flow</h2>
    <p>The exit form uses a <code>PageController</code> with <code>NeverScrollableScrollPhysics</code>, driven entirely by the parent state. Each page is a stateless or lightly-stateful widget receiving data via constructor.</p>

    <div class="flow">
      <div class="flow-step">
        <div class="flow-box active">ExitFormScreen</div>
        <div class="flow-num">State Host</div>
      </div>
      <div class="flow-arrow">→</div>
      <div class="flow-step">
        <div class="flow-box">PageView</div>
        <div class="flow-num">Router</div>
      </div>
      <div class="flow-arrow">→</div>
      <div class="flow-step">
        <div class="flow-box">ExitPage*</div>
        <div class="flow-num">5 Pages</div>
      </div>
      <div class="flow-arrow">→</div>
      <div class="flow-step">
        <div class="flow-box">ExitWidgets</div>
        <div class="flow-num">Components</div>
      </div>
      <div class="flow-arrow">→</div>
      <div class="flow-step">
        <div class="flow-box">ExitTheme</div>
        <div class="flow-num">Design Tokens</div>
      </div>
    </div>

    <div class="features">
      <div class="feature">
        <div class="feature-num">01</div>
        <div class="feature-body">
          <h3>Lifted State Pattern</h3>
          <p>All mutable state (selected reasons, ratings, signature) lives in <code>_ExitFormScreenState</code> and is passed down via constructors. No state management library needed for this scope.</p>
        </div>
      </div>
      <div class="feature">
        <div class="feature-num">02</div>
        <div class="feature-body">
          <h3>Animated Step Dots</h3>
          <p>The step bar uses <code>AnimatedContainer</code> to expand the active dot from 6px to 22px width with a 300ms ease transition.</p>
        </div>
      </div>
      <div class="feature">
        <div class="feature-num">03</div>
        <div class="feature-body">
          <h3>Toast System</h3>
          <p>A <code>Stack</code>-overlay toast with <code>FadeTransition</code> + <code>SlideTransition</code> auto-dismisses after 3 seconds using <code>Future.delayed</code>.</p>
        </div>
      </div>
      <div class="feature">
        <div class="feature-num">04</div>
        <div class="feature-body">
          <h3>Validation Guards</h3>
          <p>Each step validates before advancing: step 2 requires at least one reason selected, step 5 requires the signature before enabling submit.</p>
        </div>
      </div>
      <div class="feature">
        <div class="feature-num">05</div>
        <div class="feature-body">
          <h3>Responsive Sizing</h3>
          <p>All dimensions use <code>flutter_screenutil</code> — <code>.w</code>, <code>.h</code>, <code>.sp</code>, <code>.r</code> extensions against a 430×932 design canvas.</p>
        </div>
      </div>
      <div class="feature">
        <div class="feature-num">06</div>
        <div class="feature-body">
          <h3>Payload Builder</h3>
          <p><code>_buildPayload()</code> assembles the complete form data into a typed <code>Map&lt;String, dynamic&gt;</code> ready for API submission.</p>
        </div>
      </div>
    </div>
  </section>
</div>

<!-- ═══════════ PROJECT STRUCTURE ═══════════ -->
<div class="wrap">
  <section class="reveal">
    <div class="section-label">File Structure</div>
    <h2>Project Layout</h2>
    <p>Feature-first organization keeps each module self-contained. Shared widgets and theme tokens live in <code>core/</code>.</p>

    <div class="tree">
      <div><span class="tree-folder">📁 lib/</span></div>
      <div class="tree-indent1"><span class="tree-file">main.dart</span> <span class="tree-comment">// ScreenUtilInit + app entry</span></div>
      <div class="tree-indent1"><span class="tree-folder">📁 features/</span></div>
      <div class="tree-indent2"><span class="tree-folder">📁 exit_page/</span></div>
      <div class="tree-indent3"><span class="tree-folder">📁 screens/</span></div>
      <div class="tree-indent3" style="padding-left:80px"><span class="tree-file">exit_form_screen.dart</span> <span class="tree-comment">// main state host</span></div>
      <div class="tree-indent3" style="padding-left:80px"><span class="tree-file">exit_page_employee_info.dart</span></div>
      <div class="tree-indent3" style="padding-left:80px"><span class="tree-file">exit_page_reasons.dart</span></div>
      <div class="tree-indent3" style="padding-left:80px"><span class="tree-file">exit_page_ratings.dart</span></div>
      <div class="tree-indent3" style="padding-left:80px"><span class="tree-file">exit_page_feedback.dart</span></div>
      <div class="tree-indent3" style="padding-left:80px"><span class="tree-file">exit_page_signature.dart</span></div>
      <div class="tree-indent3"><span class="tree-folder">📁 widgets/</span></div>
      <div class="tree-indent3" style="padding-left:80px"><span class="tree-file">exit_widgets.dart</span> <span class="tree-comment">// 10+ reusable widgets</span></div>
      <div class="tree-indent3"><span class="tree-file">exit_theme.dart</span> <span class="tree-comment">// design tokens</span></div>
      <div class="tree-indent2"><span class="tree-folder">📁 rc_rollback/</span></div>
      <div class="tree-indent3"><span class="tree-folder">📁 screens/</span></div>
      <div class="tree-indent3" style="padding-left:80px"><span class="tree-file">rc_customer_details_screen.dart</span></div>
      <div class="tree-indent1"><span class="tree-folder">📁 core/</span></div>
      <div class="tree-indent2"><span class="tree-file">config/app_routes.dart</span></div>
      <div class="tree-indent2"><span class="tree-file">widgets/base_screen.dart</span></div>
      <div class="tree-indent2"><span class="tree-file">widgets/custom_textfield.dart</span></div>
      <div class="tree-indent2"><span class="tree-file">widgets/no_internet.dart</span></div>
    </div>
  </section>
</div>

<!-- ═══════════ COMPONENT LIBRARY ═══════════ -->
<div class="wrap">
  <section class="reveal">
    <div class="section-label">Component Library</div>
    <h2>Exit Widgets Reference</h2>
    <p>All UI primitives are defined in <code>exit_widgets.dart</code>. Each widget is fully self-contained and receives data via constructor props.</p>

    <table class="errors-table">
      <thead>
        <tr>
          <th>Widget</th>
          <th>Props</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><code>ExitAppHeader</code></td>
          <td>—</td>
          <td>Navy top bar with ISP branding, extends edge-to-edge behind status bar</td>
        </tr>
        <tr>
          <td><code>ExitStepBar</code></td>
          <td>currentStep, totalSteps, stepLabel</td>
          <td>Animated progress dots with expanding active indicator</td>
        </tr>
        <tr>
          <td><code>ExitNavFooter</code></td>
          <td>showBack, onBack, onNext, nextStyle, loading</td>
          <td>Back + Next/Submit/Done footer with 3 style variants</td>
        </tr>
        <tr>
          <td><code>ExitCard</code></td>
          <td>child, padding?</td>
          <td>Rounded white card with border, used as section container</td>
        </tr>
        <tr>
          <td><code>ExitReadOnlyField</code></td>
          <td>label, value</td>
          <td>Auto-filled display field with muted background</td>
        </tr>
        <tr>
          <td><code>ExitCheckItem</code></td>
          <td>label, selected, onToggled</td>
          <td>Animated checkbox row, blue highlight when selected</td>
        </tr>
        <tr>
          <td><code>ExitStarRatingRow</code></td>
          <td>aspect, rating, onRated, isLast</td>
          <td>5-star amber rating with animated switcher on tap</td>
        </tr>
        <tr>
          <td><code>ExitFeedbackBlock</code></td>
          <td>number, question, controller</td>
          <td>Numbered question with 3-line text area</td>
        </tr>
        <tr>
          <td><code>ExitTextField</code></td>
          <td>label, controller, hint, keyboardType, maxLines</td>
          <td>Labeled text input with consistent border styling</td>
        </tr>
        <tr>
          <td><code>ExitSignatureArea</code></td>
          <td>signed, onTap</td>
          <td>Animated signature box, transitions to green on sign</td>
        </tr>
        <tr>
          <td><code>ExitSuccessView</code></td>
          <td>employeeName</td>
          <td>Full-screen success state with green checkmark</td>
        </tr>
        <tr>
          <td><code>ExitToast</code></td>
          <td>message, visible</td>
          <td>Fade+slide toast overlay with auto-dismiss</td>
        </tr>
      </tbody>
    </table>
  </section>
</div>

<!-- ═══════════ BUGS RESOLVED ═══════════ -->
<div class="wrap">
  <section class="reveal">
    <div class="section-label">Debug Log</div>
    <h2>Issues Resolved</h2>
    <p>All runtime errors encountered during development have been diagnosed and fixed.</p>

    <table class="errors-table">
      <thead>
        <tr>
          <th>Error</th>
          <th>Location</th>
          <th>Fix</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><code>color == null || decoration == null</code></td>
          <td>rc_customer_details_screen.dart:172</td>
          <td>Moved <code>color</code> inside <code>BoxDecoration</code></td>
          <td><span class="badge fixed">✓ Fixed</span></td>
        </tr>
        <tr>
          <td><code>color == null || decoration == null</code></td>
          <td>ExitStepBar · exit_widgets.dart:72</td>
          <td>Moved <code>color</code> inside <code>BoxDecoration</code></td>
          <td><span class="badge fixed">✓ Fixed</span></td>
        </tr>
        <tr>
          <td><code>color == null || decoration == null</code></td>
          <td>ExitNavFooter · exit_form_screen.dart:219</td>
          <td>Moved <code>color</code> inside <code>BoxDecoration</code></td>
          <td><span class="badge fixed">✓ Fixed</span></td>
        </tr>
        <tr>
          <td>RenderFlex overflowed 199,389px on bottom</td>
          <td>Column · exit_form_screen.dart:161</td>
          <td>Moved <code>ExitFormScreen</code> into <code>builder</code> callback so <code>MediaQuery</code> is available</td>
          <td><span class="badge fixed">✓ Fixed</span></td>
        </tr>
        <tr>
          <td>Failed host lookup: fonts.gstatic.com</td>
          <td>google_fonts (emulator)</td>
          <td>Emulator DNS issue — bundle fonts locally or fix AVD network settings</td>
          <td><span class="badge warn">⚠ Network</span></td>
        </tr>
        <tr>
          <td>Status bar showing black background</td>
          <td>ExitAppHeader SafeArea</td>
          <td>Added <code>SystemChrome.setSystemUIOverlayStyle</code> with transparent status bar + light icons; moved padding inside <code>SafeArea</code></td>
          <td><span class="badge fixed">✓ Fixed</span></td>
        </tr>
      </tbody>
    </table>
  </section>
</div>

<!-- ═══════════ TECH STACK ═══════════ -->
<div class="wrap">
  <section class="reveal">
    <div class="section-label">Dependencies</div>
    <h2>Tech Stack</h2>

    <div class="stack-grid">
      <div class="stack-item">
        <div class="stack-emoji">💙</div>
        <div class="stack-name">Flutter</div>
        <div class="stack-desc">UI framework</div>
      </div>
      <div class="stack-item">
        <div class="stack-emoji">🎯</div>
        <div class="stack-name">Dart</div>
        <div class="stack-desc">Language</div>
      </div>
      <div class="stack-item">
        <div class="stack-emoji">📐</div>
        <div class="stack-name">ScreenUtil</div>
        <div class="stack-desc">Responsive sizing</div>
      </div>
      <div class="stack-item">
        <div class="stack-emoji">🔤</div>
        <div class="stack-name">Google Fonts</div>
        <div class="stack-desc">DM Sans typeface</div>
      </div>
      <div class="stack-item">
        <div class="stack-emoji">📱</div>
        <div class="stack-name">Android</div>
        <div class="stack-desc">Target platform</div>
      </div>
      <div class="stack-item">
        <div class="stack-emoji">🧭</div>
        <div class="stack-name">GoRouter</div>
        <div class="stack-desc">Navigation</div>
      </div>
      <div class="stack-item">
        <div class="stack-emoji">🎨</div>
        <div class="stack-name">Material 3</div>
        <div class="stack-desc">Design system base</div>
      </div>
      <div class="stack-item">
        <div class="stack-emoji">⚙️</div>
        <div class="stack-name">Services</div>
        <div class="stack-desc">SystemChrome UI</div>
      </div>
    </div>
  </section>
</div>

<!-- ═══════════ SETUP ═══════════ -->
<div class="wrap">
  <section class="reveal">
    <div class="section-label">Getting Started</div>
    <h2>Setup & Run</h2>

    <div class="setup-steps">
      <div class="setup-step">
        <div class="step-num">1</div>
        <div class="step-content">
          <h3>Clone the repository</h3>
          <div class="code-wrap">
            <div class="code-header">
              <div class="code-dot r"></div><div class="code-dot y"></div><div class="code-dot g"></div>
              <span class="code-file">terminal</span>
            </div>
            <pre><span class="f">git</span> <span class="s">clone</span> https://github.com/your-org/engine_mini.git
<span class="f">cd</span> engine_mini</pre>
          </div>
        </div>
      </div>

      <div class="setup-step">
        <div class="step-num">2</div>
        <div class="step-content">
          <h3>Install dependencies</h3>
          <div class="code-wrap">
            <div class="code-header">
              <div class="code-dot r"></div><div class="code-dot y"></div><div class="code-dot g"></div>
              <span class="code-file">terminal</span>
            </div>
            <pre><span class="f">flutter</span> pub get</pre>
          </div>
        </div>
      </div>

      <div class="setup-step">
        <div class="step-num">3</div>
        <div class="step-content">
          <h3>Run on Android device or emulator</h3>
          <div class="code-wrap">
            <div class="code-header">
              <div class="code-dot r"></div><div class="code-dot y"></div><div class="code-dot g"></div>
              <span class="code-file">terminal</span>
            </div>
            <pre><span class="f">flutter</span> run <span class="c">-d android</span></pre>
          </div>
          <p style="font-size:12px;margin-top:8px">Ensure <code>INTERNET</code> permission is declared in <code>AndroidManifest.xml</code> for Google Fonts to load.</p>
        </div>
      </div>

      <div class="setup-step">
        <div class="step-num">4</div>
        <div class="step-content">
          <h3>Switch active screen in main.dart</h3>
          <div class="code-wrap">
            <div class="code-header">
              <div class="code-dot r"></div><div class="code-dot y"></div><div class="code-dot g"></div>
              <span class="code-file">lib/main.dart</span>
            </div>
            <pre><span class="k">child</span>: <span class="t">ExitFormScreen</span>(),         <span class="c">// Exit Interview</span>
<span class="c">// child: RcCustomerDetailsScreen(), // RC Rollback</span></pre>
          </div>
        </div>
      </div>
    </div>
  </section>
</div>

<!-- ═══════════ FOOTER ═══════════ -->
<div class="wrap">
  <footer>
    <div class="footer-logo">Engine <span>Mini</span></div>
    <p>Flutter · Dart · Field Operations Tooling</p>
    <div class="footer-links">
      <a href="#">Flutter Docs</a>
      <a href="#">ScreenUtil</a>
      <a href="#">DM Sans Font</a>
      <a href="#">Report Issue</a>
    </div>
  </footer>
</div>

<script>
  // Scroll reveal
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(e => {
      if (e.isIntersecting) {
        e.target.classList.add('visible');
        observer.unobserve(e.target);
      }
    });
  }, { threshold: 0.1 });

  document.querySelectorAll('.reveal').forEach(el => observer.observe(el));
</script>

</body>
</html>