const $ = (id) => document.getElementById(id);
const base = () => $("apiBase").value.trim().replace(/\/+$/, "");
const userId = () => $("userId").value.trim();

function toast(message) {
  const el = $("toast"); el.textContent = message; el.classList.add("show");
  clearTimeout(toast.timer); toast.timer = setTimeout(() => el.classList.remove("show"), 3000);
}
function query(params) {
  return new URLSearchParams(params).toString();
}
async function request(path, options = {}) {
  const response = await fetch(`${base()}${path}`, options);
  const contentType = response.headers.get("content-type") || "";
  let data;
  if (contentType.includes("application/json")) data = await response.json();
  else if (contentType.includes("text/")) data = await response.text();
  else data = await response.blob();
  if (!response.ok) {
    const message = typeof data === "object" && !(data instanceof Blob)
      ? JSON.stringify(data) : String(data);
    throw new Error(`${response.status} ${response.statusText}: ${message}`);
  }
  return { data, response };
}
function show(id, value) {
  $(id).textContent = typeof value === "string" ? value : JSON.stringify(value, null, 2);
}
function ensureInputs() {
  if (!base()) throw new Error("Enter your FastAPI base URL.");
  if (!userId()) throw new Error("Enter your user ID.");
}
function setBusy(button, busy, label) {
  button.disabled = busy;
  if (busy) { button.dataset.original = button.textContent; button.textContent = label || "Working..."; }
  else if (button.dataset.original) button.textContent = button.dataset.original;
}
function pickName(item) {
  if (typeof item === "string") return item;
  return item.object_name || item.file_name || item.filename || item.name || item.key || "";
}
function renderFiles(data) {
  const list = $("fileList"); list.innerHTML = "";
  let items = Array.isArray(data) ? data : (data?.data || data?.files || data?.objects || []);
  if (!Array.isArray(items)) items = [];
  if (!items.length) { list.innerHTML = '<div class="empty-state">No files returned. Check the API response below in your backend logs.</div>'; return; }
  items.forEach(item => {
    const name = pickName(item);
    const row = document.createElement("div"); row.className = "file-item";
    const info = document.createElement("div");
    const strong = document.createElement("strong"); strong.textContent = name || "PDF object";
    const small = document.createElement("small"); small.textContent = item.size ? `${item.size} bytes` : "Stored object";
    info.append(strong, small);
    const actions = document.createElement("button"); actions.className = "button button-quiet"; actions.textContent = "Use";
    actions.addEventListener("click", () => {
      $("readFileName").value = name.split("/").pop();
      $("deleteObjectName").value = name;
      $("stirlingFileName").value = name.split("/").pop();
    });
    row.append(info, actions); list.append(row);
  });
}

$("pdfFile").addEventListener("change", e => {
  $("fileLabel").textContent = e.target.files[0]?.name || "Choose a PDF file";
});
$("checkConnection").addEventListener("click", async e => {
  const button = e.currentTarget; setBusy(button, true, "Checking...");
  try {
    const res = await fetch(`${base()}/openapi.json`);
    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    $("connectionDot").className = "status-dot online"; $("connectionText").textContent = "API reachable";
    toast("FastAPI is reachable.");
  } catch (err) {
    $("connectionDot").className = "status-dot offline"; $("connectionText").textContent = "Connection failed";
    toast(err.message);
  } finally { setBusy(button, false); }
});

$("uploadFile").addEventListener("click", async e => {
  const button = e.currentTarget; setBusy(button, true, "Uploading...");
  try {
    ensureInputs();
    const file = $("pdfFile").files[0];
    if (!file) throw new Error("Choose a PDF first.");
    if (file.type !== "application/pdf" && !file.name.toLowerCase().endsWith(".pdf")) throw new Error("Only PDF files are supported.");
    const form = new FormData(); form.append("file", file);
    const { data } = await request(`/api/v1/minio/putobject?${query({user_id:userId()})}`, {method:"POST", body:form});
    show("uploadResult", data); toast("Upload request completed.");
    await loadFiles();
  } catch (err) { show("uploadResult", err.message); toast(err.message); }
  finally { setBusy(button, false); }
});

async function loadFiles() {
  ensureInputs();
  const { data } = await request(`/api/v1/minio/getlistobject?${query({user_id:userId()})}`);
  renderFiles(data); return data;
}
$("refreshFiles").addEventListener("click", async e => {
  const button = e.currentTarget; setBusy(button, true, "Loading...");
  try { const data = await loadFiles(); toast("File list refreshed."); }
  catch (err) { $("fileList").textContent = err.message; toast(err.message); }
  finally { setBusy(button, false); }
});

$("readFile").addEventListener("click", async e => {
  const button = e.currentTarget; setBusy(button, true, "Reading...");
  try {
    ensureInputs();
    const fileName = $("readFileName").value.trim();
    if (!fileName) throw new Error("Enter a file name.");
    const { data } = await request(`/api/v1/minio/getobject?${query({user_id:userId(),file_name:fileName})}`);
    show("pdfContent", data);
  } catch (err) { show("pdfContent", err.message); toast(err.message); }
  finally { setBusy(button, false); }
});

$("deleteFile").addEventListener("click", async e => {
  const button = e.currentTarget; setBusy(button, true, "Deleting...");
  try {
    ensureInputs();
    const objectName = $("deleteObjectName").value.trim();
    if (!objectName) throw new Error("Enter the exact object name.");
    if (!confirm(`Delete ${objectName}?`)) return;
    const { data } = await request("/api/v1/minio/deleteobject", {
      method:"DELETE", headers:{"Content-Type":"application/json"},
      body:JSON.stringify({user_id:userId(), object_name:objectName})
    });
    show("deleteResult", data); toast("Delete request completed."); await loadFiles();
  } catch (err) { show("deleteResult", err.message); toast(err.message); }
  finally { setBusy(button, false); }
});

$("stirlingUpload").addEventListener("click", async e => {
  const button = e.currentTarget; setBusy(button, true, "Sending...");
  try {
    ensureInputs();
    const fileName = $("stirlingFileName").value.trim();
    if (!fileName) throw new Error("Enter a stored file name.");
    const { data } = await request(`/api/v1/stirling/upload?${query({user_id:userId(),file_name:fileName})}`, {method:"POST"});
    show("stirlingResult", data);
    const id = data?.file_id || data?.fileId || data?.data?.file_id || data?.data?.fileId;
    if (id) $("stirlingFileId").value = id;
    toast("Stirling upload request completed.");
  } catch (err) { show("stirlingResult", err.message); toast(err.message); }
  finally { setBusy(button, false); }
});

$("stirlingDownload").addEventListener("click", async e => {
  const button = e.currentTarget; setBusy(button, true, "Downloading...");
  try {
    ensureInputs();
    const fileName = $("stirlingFileName").value.trim();
    const fileId = $("stirlingFileId").value.trim();
    if (!fileName || !fileId) throw new Error("Enter both file name and Stirling file ID.");
    const { data, response } = await request(`/api/v1/stirling/download?${query({user_id:userId(),file_name:fileName,file_id:fileId})}`);
    if (data instanceof Blob) {
      const url = URL.createObjectURL(data); const a = document.createElement("a");
      a.href = url; a.download = fileName; a.click(); URL.revokeObjectURL(url);
      show("stirlingResult", "Download started.");
    } else show("stirlingResult", data);
    toast("Stirling download request completed.");
  } catch (err) { show("stirlingResult", err.message); toast(err.message); }
  finally { setBusy(button, false); }
});

function addMessage(text, role) {
  const box = $("chatMessages");
  const placeholder = box.querySelector(".chat-placeholder"); if (placeholder) placeholder.remove();
  const node = document.createElement("div"); node.className = `message ${role}`; node.textContent = text;
  box.append(node); box.scrollTop = box.scrollHeight;
}
$("chatForm").addEventListener("submit", async e => {
  e.preventDefault();
  const input = $("chatInput"); const text = input.value.trim();
  if (!text) return;
  try {
    ensureInputs();
    const fileId = $("agentFileId").value.trim();
    if (!fileId) throw new Error("Enter the file ID required by your agent endpoint.");
    addMessage(text, "user"); input.value = "";
    const { data } = await request("/api/v1/agent/respones", {
      method:"POST", headers:{"Content-Type":"application/json"},
      body:JSON.stringify({user_id:userId(),input_text:text,file_id:fileId})
    });
    const answer = typeof data === "string" ? data : JSON.stringify(data, null, 2);
    addMessage(answer, "agent");
  } catch (err) { addMessage(`Request failed: ${err.message}`, "agent"); toast(err.message); }
});

document.querySelectorAll(".nav-link").forEach(link => link.addEventListener("click", () => {
  document.querySelectorAll(".nav-link").forEach(item => item.classList.remove("active"));
  link.classList.add("active");
}));
