<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products — Product Management</title>
    <meta name="description" content="Manage products">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --bg: #f5f6fa;
            --surface: #ffffff;
            --surface-hover: #fafafa;
            --border: #e8eaed;
            --border-light: #f0f1f3;
            --text-primary: #111827;
            --text-secondary: #6b7280;
            --text-muted: #9ca3af;
            --accent: #4f46e5;
            --accent-light: #ede9fe;
            --accent-hover: #4338ca;
            --danger: #ef4444;
            --danger-light: #fef2f2;
            --success: #10b981;
            --success-light: #d1fae5;
            --warning: #f59e0b;
            --warning-light: #fef3c7;
            --shadow-sm: 0 1px 2px rgba(0,0,0,0.05);
            --shadow: 0 1px 3px rgba(0,0,0,0.08), 0 1px 2px rgba(0,0,0,0.04);
            --shadow-md: 0 4px 6px rgba(0,0,0,0.06), 0 2px 4px rgba(0,0,0,0.04);
            --radius: 12px;
            --radius-sm: 8px;
        }

        body {
            font-family: 'Inter', system-ui, sans-serif;
            background: var(--bg);
            color: var(--text-primary);
            min-height: 100vh;
            font-size: 14px;
            line-height: 1.5;
        }

        /* ── NAV ── */
        .topbar {
            background: var(--surface);
            border-bottom: 1px solid var(--border);
            position: sticky; top: 0; z-index: 100;
        }
        .topbar-inner {
            max-width: 1280px; margin: 0 auto;
            padding: 0 24px; height: 56px;
            display: flex; align-items: center; gap: 32px;
        }
        .brand { font-weight: 700; font-size: 15px; color: var(--text-primary); letter-spacing: -0.02em; white-space: nowrap; }
        .nav-links { display: flex; gap: 4px; flex: 1; }
        .nav-link {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 6px 12px; border-radius: 8px;
            font-size: 13.5px; font-weight: 500;
            color: var(--text-secondary); text-decoration: none;
            transition: background 0.15s, color 0.15s;
        }
        .nav-link:hover { background: var(--bg); color: var(--text-primary); }
        .nav-link.active { background: var(--accent-light); color: var(--accent); }
        .nav-link i { font-size: 14px; }

        /* ── PAGE ── */
        .page { max-width: 1280px; margin: 0 auto; padding: 32px 24px; }
        .page-header {
            display: flex; align-items: flex-end;
            justify-content: space-between; margin-bottom: 24px;
        }
        .page-title { font-size: 22px; font-weight: 700; letter-spacing: -0.03em; }
        .page-subtitle { font-size: 13px; color: var(--text-muted); margin-top: 2px; }
        .count-badge {
            display: inline-flex; align-items: center;
            background: var(--accent-light); color: var(--accent);
            font-size: 11px; font-weight: 600;
            padding: 1px 8px; border-radius: 20px; margin-left: 8px;
        }

        /* ── TOOLBAR ── */
        .toolbar { display: flex; align-items: center; justify-content: space-between; gap: 12px; margin-bottom: 16px; }
        .search-wrap { position: relative; flex: 0 0 280px; }
        .search-wrap i { position: absolute; left: 11px; top: 50%; transform: translateY(-50%); color: var(--text-muted); font-size: 14px; }
        .search-input {
            width: 100%; padding: 8px 12px 8px 34px;
            border: 1px solid var(--border); border-radius: var(--radius-sm);
            font-size: 13.5px; font-family: inherit;
            background: var(--surface); color: var(--text-primary);
            outline: none; transition: border-color 0.15s, box-shadow 0.15s;
        }
        .search-input:focus { border-color: var(--accent); box-shadow: 0 0 0 3px rgba(79,70,229,0.1); }
        .search-input::placeholder { color: var(--text-muted); }

        /* ── BUTTONS ── */
        .btn {
            display: inline-flex; align-items: center; gap: 7px;
            padding: 8px 16px; border-radius: var(--radius-sm);
            font-size: 13.5px; font-weight: 500; font-family: inherit;
            cursor: pointer; border: none;
            transition: all 0.15s; text-decoration: none; line-height: 1;
        }
        .btn-primary { background: var(--accent); color: #fff; box-shadow: var(--shadow-sm); }
        .btn-primary:hover { background: var(--accent-hover); box-shadow: var(--shadow); }
        .btn-ghost { background: transparent; color: var(--text-secondary); border: 1px solid var(--border); }
        .btn-ghost:hover { background: var(--bg); color: var(--text-primary); }
        .btn-danger-ghost { background: transparent; color: var(--danger); border: 1px solid transparent; }
        .btn-danger-ghost:hover { background: var(--danger-light); border-color: #fca5a5; }
        .btn-danger { background: var(--danger); color: #fff; }
        .btn-danger:hover { background: #dc2626; }
        .btn-sm { padding: 5px 10px; font-size: 12.5px; border-radius: 7px; }

        /* ── TABLE ── */
        .card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
        }
        .table-wrap { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; min-width: 900px; }
        thead th {
            background: #fafafa;
            border-bottom: 1px solid var(--border);
            padding: 11px 14px;
            text-align: left;
            font-size: 11.5px; font-weight: 600;
            text-transform: uppercase; letter-spacing: 0.06em;
            color: var(--text-muted); white-space: nowrap;
        }
        tbody td {
            padding: 12px 14px;
            border-bottom: 1px solid var(--border-light);
            font-size: 13.5px;
            vertical-align: middle;
        }
        tbody tr:last-child td { border-bottom: none; }
        tbody tr { transition: background 0.12s; }
        tbody tr:hover { background: var(--surface-hover); }

        .thumb {
            width: 44px; height: 44px;
            border-radius: 8px;
            object-fit: cover;
            border: 1px solid var(--border);
            display: block;
        }
        .thumb-placeholder {
            width: 44px; height: 44px;
            border-radius: 8px;
            background: var(--bg);
            border: 1px solid var(--border);
            display: inline-flex; align-items: center; justify-content: center;
            color: var(--text-muted); font-size: 16px;
        }

        .prod-name { font-weight: 500; color: var(--text-primary); }
        .cat-tag {
            display: inline-flex; align-items: center;
            background: var(--bg); border: 1px solid var(--border);
            color: var(--text-secondary);
            font-size: 11.5px; font-weight: 500;
            padding: 2px 9px; border-radius: 20px;
        }
        .price { font-variant-numeric: tabular-nums; font-weight: 500; }
        .discount { color: var(--warning); font-weight: 500; font-size: 12.5px; }
        .no-discount { color: var(--text-muted); }
        .status-badge {
            display: inline-flex; align-items: center; gap: 4px;
            padding: 3px 9px; border-radius: 20px;
            font-size: 12px; font-weight: 600;
        }
        .status-active { background: var(--success-light); color: #065f46; }
        .status-inactive { background: var(--bg); color: var(--text-muted); border: 1px solid var(--border); }
        .status-dot { width: 5px; height: 5px; border-radius: 50%; }
        .status-active .status-dot { background: var(--success); }
        .status-inactive .status-dot { background: var(--text-muted); }
        .actions { display: flex; gap: 4px; }
        .row-id { color: var(--text-muted); font-variant-numeric: tabular-nums; }

        /* ── EMPTY ── */
        .empty { padding: 64px 24px; text-align: center; color: var(--text-muted); }
        .empty-icon {
            width: 52px; height: 52px; background: var(--bg);
            border-radius: 12px; display: inline-flex;
            align-items: center; justify-content: center;
            font-size: 22px; color: var(--text-muted); margin-bottom: 14px;
        }
        .empty h3 { font-size: 14px; font-weight: 600; color: var(--text-secondary); margin-bottom: 4px; }
        .empty p { font-size: 13px; }

        /* ── MODAL ── */
        .modal-overlay {
            position: fixed; inset: 0;
            background: rgba(17,24,39,0.4);
            backdrop-filter: blur(2px);
            display: flex; align-items: center; justify-content: center;
            z-index: 500; opacity: 0; pointer-events: none;
            transition: opacity 0.2s;
        }
        .modal-overlay.open { opacity: 1; pointer-events: all; }
        .modal {
            background: var(--surface); border-radius: 16px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
            width: 560px; max-width: calc(100vw - 32px);
            max-height: calc(100vh - 48px); overflow-y: auto;
            transform: translateY(12px) scale(0.98);
            transition: transform 0.2s, opacity 0.2s;
            opacity: 0;
        }
        .modal-overlay.open .modal { transform: translateY(0) scale(1); opacity: 1; }
        .modal-head {
            padding: 20px 24px 16px;
            border-bottom: 1px solid var(--border);
            display: flex; align-items: center; justify-content: space-between;
            position: sticky; top: 0; background: var(--surface); z-index: 1;
        }
        .modal-title { font-size: 15px; font-weight: 600; letter-spacing: -0.01em; }
        .modal-close {
            width: 30px; height: 30px; display: flex; align-items: center; justify-content: center;
            border-radius: 6px; border: none; background: none; cursor: pointer;
            color: var(--text-muted); font-size: 16px; transition: background 0.15s;
        }
        .modal-close:hover { background: var(--bg); color: var(--text-primary); }
        .modal-body { padding: 20px 24px; }
        .modal-foot {
            padding: 16px 24px; border-top: 1px solid var(--border);
            display: flex; justify-content: flex-end; gap: 8px;
            position: sticky; bottom: 0; background: var(--surface); z-index: 1;
        }

        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }
        .form-full { grid-column: 1 / -1; }
        .form-group { display: flex; flex-direction: column; gap: 6px; }
        label { font-size: 12.5px; font-weight: 500; color: var(--text-secondary); }
        .req { color: var(--danger); }
        .form-control {
            padding: 9px 12px; border: 1px solid var(--border);
            border-radius: var(--radius-sm); font-size: 13.5px;
            font-family: inherit; color: var(--text-primary);
            background: var(--surface); outline: none;
            transition: border-color 0.15s, box-shadow 0.15s;
            width: 100%;
        }
        .form-control:focus { border-color: var(--accent); box-shadow: 0 0 0 3px rgba(79,70,229,0.1); }
        select.form-control { cursor: pointer; }
        textarea.form-control { resize: vertical; min-height: 80px; }
        .form-hint { font-size: 11.5px; color: var(--text-muted); }

        /* ── CONFIRM ── */
        .confirm-icon {
            width: 44px; height: 44px; background: var(--danger-light);
            border-radius: 10px; display: flex; align-items: center; justify-content: center;
            font-size: 20px; color: var(--danger); margin-bottom: 12px;
        }
        .confirm-title { font-size: 15px; font-weight: 600; margin-bottom: 6px; }
        .confirm-desc { font-size: 13px; color: var(--text-secondary); line-height: 1.5; }

        /* ── TOAST ── */
        #toasts {
            position: fixed; top: 20px; right: 20px;
            z-index: 9999; display: flex; flex-direction: column; gap: 8px;
        }
        .toast {
            display: flex; align-items: center; gap: 10px;
            background: var(--surface); border: 1px solid var(--border);
            border-radius: 10px; padding: 12px 16px;
            font-size: 13.5px; box-shadow: var(--shadow-md);
            min-width: 260px; animation: slideIn 0.2s ease;
        }
        .toast-success { border-left: 3px solid var(--success); }
        .toast-error { border-left: 3px solid var(--danger); }
        .toast i { font-size: 16px; flex-shrink: 0; }
        .toast-success i { color: var(--success); }
        .toast-error i { color: var(--danger); }
        @keyframes slideIn {
            from { opacity: 0; transform: translateX(16px); }
            to { opacity: 1; transform: translateX(0); }
        }
    </style>
</head>
<body>

<div class="topbar">
    <div class="topbar-inner">
        <span class="brand">Management</span>
        <nav class="nav-links">
            <a href="/categories" class="nav-link"><i class="bi bi-tag"></i> Categories</a>
            <a href="/products" class="nav-link active"><i class="bi bi-box"></i> Products</a>
            <a href="/swagger-ui/index.html" class="nav-link" target="_blank"><i class="bi bi-braces"></i> API Docs</a>
        </nav>
    </div>
</div>

<div id="toasts"></div>

<div class="page">
    <div class="page-header">
        <div>
            <h1 class="page-title">Products <span class="count-badge" id="countBadge">0</span></h1>
            <p class="page-subtitle">Browse, add and manage your product catalogue</p>
        </div>
        <button class="btn btn-primary" onclick="openAdd()">
            <i class="bi bi-plus-lg"></i> New Product
        </button>
    </div>

    <div class="toolbar">
        <div class="search-wrap">
            <i class="bi bi-search"></i>
            <input type="text" class="search-input" id="searchInput" placeholder="Filter products…">
        </div>
    </div>

    <div class="card">
        <div class="table-wrap">
            <table>
                <thead>
                <tr>
                    <th style="width:44px">#</th>
                    <th style="width:60px">Image</th>
                    <th>Product Name</th>
                    <th>Category</th>
                    <th>Unit Price</th>
                    <th>Discount</th>
                    <th>Qty</th>
                    <th>Status</th>
                    <th style="width:130px">Actions</th>
                </tr>
                </thead>
                <tbody id="tbody">
                <tr><td colspan="9"><div class="empty"><div class="empty-icon"><i class="bi bi-arrow-repeat"></i></div><p>Loading…</p></div></td></tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- ADD MODAL -->
<div class="modal-overlay" id="addOverlay">
    <div class="modal">
        <div class="modal-head">
            <span class="modal-title">New Product</span>
            <button class="modal-close" onclick="closeAdd()"><i class="bi bi-x"></i></button>
        </div>
        <div class="modal-body">
            <div class="form-grid">
                <div class="form-group form-full">
                    <label>Product Name <span class="req">*</span></label>
                    <input type="text" id="add-name" class="form-control" placeholder="e.g. Wireless Headphones">
                </div>
                <div class="form-group">
                    <label>Category <span class="req">*</span></label>
                    <select id="add-cat" class="form-control"><option value="">Select category…</option></select>
                </div>
                <div class="form-group">
                    <label>Status</label>
                    <select id="add-status" class="form-control">
                        <option value="1">Active</option>
                        <option value="0">Inactive</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Unit Price (VNĐ) <span class="req">*</span></label>
                    <input type="number" id="add-price" class="form-control" min="0" step="1000" value="0">
                </div>
                <div class="form-group">
                    <label>Discount (%)</label>
                    <input type="number" id="add-discount" class="form-control" min="0" max="100" step="0.5" value="0">
                </div>
                <div class="form-group">
                    <label>Quantity</label>
                    <input type="number" id="add-qty" class="form-control" min="0" value="0">
                </div>
                <div class="form-group">
                    <label>Product Image</label>
                    <input type="file" id="add-img" class="form-control" accept="image/*">
                </div>
                <div class="form-group form-full">
                    <label>Description</label>
                    <textarea id="add-desc" class="form-control" placeholder="Optional description…"></textarea>
                </div>
            </div>
        </div>
        <div class="modal-foot">
            <button class="btn btn-ghost" onclick="closeAdd()">Cancel</button>
            <button class="btn btn-primary" onclick="submitAdd()"><i class="bi bi-check-lg"></i> Save</button>
        </div>
    </div>
</div>

<!-- EDIT MODAL -->
<div class="modal-overlay" id="editOverlay">
    <div class="modal">
        <div class="modal-head">
            <span class="modal-title">Edit Product</span>
            <button class="modal-close" onclick="closeEdit()"><i class="bi bi-x"></i></button>
        </div>
        <div class="modal-body">
            <input type="hidden" id="edit-id">
            <div class="form-grid">
                <div class="form-group form-full">
                    <label>Product Name <span class="req">*</span></label>
                    <input type="text" id="edit-name" class="form-control">
                </div>
                <div class="form-group">
                    <label>Category <span class="req">*</span></label>
                    <select id="edit-cat" class="form-control"><option value="">Select category…</option></select>
                </div>
                <div class="form-group">
                    <label>Status</label>
                    <select id="edit-status" class="form-control">
                        <option value="1">Active</option>
                        <option value="0">Inactive</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Unit Price (VNĐ)</label>
                    <input type="number" id="edit-price" class="form-control" min="0" step="1000">
                </div>
                <div class="form-group">
                    <label>Discount (%)</label>
                    <input type="number" id="edit-discount" class="form-control" min="0" max="100" step="0.5">
                </div>
                <div class="form-group">
                    <label>Quantity</label>
                    <input type="number" id="edit-qty" class="form-control" min="0">
                </div>
                <div class="form-group">
                    <label>Replace Image</label>
                    <div id="edit-cur-img" style="margin-bottom:6px"></div>
                    <input type="file" id="edit-img" class="form-control" accept="image/*">
                    <span class="form-hint">Leave empty to keep current image.</span>
                </div>
                <div class="form-group form-full">
                    <label>Description</label>
                    <textarea id="edit-desc" class="form-control"></textarea>
                </div>
            </div>
        </div>
        <div class="modal-foot">
            <button class="btn btn-ghost" onclick="closeEdit()">Cancel</button>
            <button class="btn btn-primary" onclick="submitEdit()"><i class="bi bi-check-lg"></i> Update</button>
        </div>
    </div>
</div>

<!-- DELETE MODAL -->
<div class="modal-overlay" id="delOverlay">
    <div class="modal" style="width:380px">
        <div class="modal-body" style="padding-top:24px">
            <div class="confirm-icon"><i class="bi bi-trash3"></i></div>
            <p class="confirm-title">Delete Product?</p>
            <p class="confirm-desc">You're about to delete <strong id="del-name"></strong>. This cannot be undone.</p>
            <input type="hidden" id="del-id">
        </div>
        <div class="modal-foot">
            <button class="btn btn-ghost" onclick="closeDel()">Cancel</button>
            <button class="btn btn-danger" onclick="submitDel()"><i class="bi bi-trash3"></i> Delete</button>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    let allProducts = [];

    const addOv = document.getElementById('addOverlay');
    const editOv = document.getElementById('editOverlay');
    const delOv = document.getElementById('delOverlay');

    function openModal(ov) { ov.classList.add('open'); }
    function closeModal(ov) { ov.classList.remove('open'); }
    function closeAdd() { closeModal(addOv); }
    function closeEdit() { closeModal(editOv); }
    function closeDel() { closeModal(delOv); }

    [addOv, editOv, delOv].forEach(ov => ov.addEventListener('click', e => { if(e.target===ov) closeModal(ov); }));

    function toast(msg, type) {
        const c = document.getElementById('toasts'), el = document.createElement('div');
        el.className = 'toast toast-' + type;
        el.innerHTML = (type==='success'?'<i class="bi bi-check-circle-fill"></i>':'<i class="bi bi-x-circle-fill"></i>') + '<span>' + esc(msg) + '</span>';
        c.prepend(el); setTimeout(() => el.remove(), 3800);
    }

    function esc(s) { return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;'); }
    function fmtPrice(v) { return Number(v||0).toLocaleString('vi-VN') + ' ₫'; }

    function loadCats(selId, selectedId) {
        $.get('/api/category', res => {
            const sel = document.getElementById(selId);
            sel.innerHTML = '<option value="">Select category…</option>';
            (res.body||[]).forEach(c => {
                const o = document.createElement('option');
                o.value = c.categoryId; o.text = c.categoryName;
                if(selectedId && c.categoryId == selectedId) o.selected = true;
                sel.appendChild(o);
            });
        });
    }

    function render(list) {
        const tbody = document.getElementById('tbody');
        document.getElementById('countBadge').textContent = list.length;
        if (!list.length) {
            tbody.innerHTML = '<tr><td colspan="9"><div class="empty"><div class="empty-icon"><i class="bi bi-box"></i></div><h3>No products yet</h3><p>Click "New Product" to get started.</p></div></td></tr>';
            return;
        }
        tbody.innerHTML = list.map((p,i) => `
        <tr>
            <td class="row-id">${i+1}</td>
            <td>${p.images ? `<img src="/uploads/${esc(p.images)}" class="thumb" alt="">` : `<span class="thumb-placeholder"><i class="bi bi-image"></i></span>`}</td>
            <td><span class="prod-name">${esc(p.productName)}</span></td>
            <td>${p.category ? `<span class="cat-tag">${esc(p.category.categoryName)}</span>` : '<span style="color:var(--text-muted)">—</span>'}</td>
            <td class="price">${fmtPrice(p.unitPrice)}</td>
            <td>${p.discount > 0 ? `<span class="discount">−${p.discount}%</span>` : '<span class="no-discount">—</span>'}</td>
            <td>${p.quantity||0}</td>
            <td>${p.status==1
                ? '<span class="status-badge status-active"><span class="status-dot"></span>Active</span>'
                : '<span class="status-badge status-inactive"><span class="status-dot"></span>Inactive</span>'}</td>
            <td><div class="actions">
                <button class="btn btn-ghost btn-sm" onclick="openEdit(${p.productId})"><i class="bi bi-pencil"></i> Edit</button>
                <button class="btn btn-danger-ghost btn-sm" onclick="openDel(${p.productId},'${esc(p.productName)}')"><i class="bi bi-trash3"></i></button>
            </div></td>
        </tr>`).join('');
    }

    function load() {
        $.get('/api/product', res => {
            allProducts = res.body || [];
            render(allProducts);
        }).fail(() => toast('Failed to load products', 'error'));
    }

    document.getElementById('searchInput').addEventListener('input', function() {
        const q = this.value.toLowerCase();
        render(allProducts.filter(p => p.productName.toLowerCase().includes(q) || (p.category && p.category.categoryName.toLowerCase().includes(q))));
    });

    function openAdd() {
        ['add-name','add-desc'].forEach(id => document.getElementById(id).value = '');
        ['add-price'].forEach(id => document.getElementById(id).value = '0');
        ['add-discount','add-qty'].forEach(id => document.getElementById(id).value = '0');
        document.getElementById('add-status').value = '1';
        document.getElementById('add-img').value = '';
        loadCats('add-cat', null);
        openModal(addOv);
    }

    function submitAdd() {
        const name = $('#add-name').val().trim(), cat = $('#add-cat').val();
        if(!name){toast('Product name is required','error');return;}
        if(!cat){toast('Please select a category','error');return;}
        const fd = new FormData();
        fd.append('productName',name); fd.append('categoryId',cat);
        fd.append('unitPrice',$('#add-price').val()||0);
        fd.append('discount',$('#add-discount').val()||0);
        fd.append('quantity',$('#add-qty').val()||0);
        fd.append('status',$('#add-status').val());
        fd.append('description',$('#add-desc').val());
        const f=$('#add-img')[0].files[0]; if(f) fd.append('imageFile',f);
        $.ajax({url:'/api/product/addProduct',method:'POST',data:fd,processData:false,contentType:false,
            success(r){if(r.status){toast('Product added','success');closeAdd();load();}else toast(r.message,'error');},
            error(x){toast(x.responseJSON?.message||'Error','error');}
        });
    }

    function openEdit(id) {
        $.ajax({url:'/api/product/getProduct',method:'POST',data:{id},
            success(r){
                if(!r.status){toast(r.message,'error');return;}
                const p=r.body;
                $('#edit-id').val(p.productId);
                $('#edit-name').val(p.productName);
                $('#edit-price').val(p.unitPrice);
                $('#edit-discount').val(p.discount||0);
                $('#edit-qty').val(p.quantity||0);
                $('#edit-status').val(p.status);
                $('#edit-desc').val(p.description||'');
                $('#edit-img').val('');
                const d=document.getElementById('edit-cur-img');
                d.innerHTML=p.images?`<img src="/uploads/${esc(p.images)}" class="thumb" style="border-radius:6px" alt="">`:'<span style="font-size:12px;color:var(--text-muted)">No image</span>';
                loadCats('edit-cat', p.category?.categoryId);
                openModal(editOv);
            },error(){toast('Failed to load','error');}
        });
    }

    function submitEdit() {
        const id=$('#edit-id').val(), name=$('#edit-name').val().trim(), cat=$('#edit-cat').val();
        if(!name){toast('Product name is required','error');return;}
        if(!cat){toast('Please select a category','error');return;}
        const fd=new FormData();
        fd.append('productId',id); fd.append('productName',name); fd.append('categoryId',cat);
        fd.append('unitPrice',$('#edit-price').val()||0);
        fd.append('discount',$('#edit-discount').val()||0);
        fd.append('quantity',$('#edit-qty').val()||0);
        fd.append('status',$('#edit-status').val());
        fd.append('description',$('#edit-desc').val());
        const f=$('#edit-img')[0].files[0]; if(f) fd.append('imageFile',f);
        $.ajax({url:'/api/product/updateProduct',method:'PUT',data:fd,processData:false,contentType:false,
            success(r){if(r.status){toast('Product updated','success');closeEdit();load();}else toast(r.message,'error');},
            error(x){toast(x.responseJSON?.message||'Error','error');}
        });
    }

    function openDel(id,name){ $('#del-id').val(id); document.getElementById('del-name').textContent=name; openModal(delOv); }
    function submitDel(){
        $.ajax({url:'/api/product/deleteProduct',method:'DELETE',data:{productId:$('#del-id').val()},
            success(r){if(r.status){toast('Deleted','success');closeDel();load();}else toast(r.message,'error');},
            error(x){toast(x.responseJSON?.message||'Error','error');}
        });
    }

    $(load);
</script>
</body>
</html>
