<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categories — Product Management</title>
    <meta name="description" content="Manage product categories">
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
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .topbar-inner {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 24px;
            height: 56px;
            display: flex;
            align-items: center;
            gap: 32px;
        }
        .brand {
            font-weight: 700;
            font-size: 15px;
            color: var(--text-primary);
            letter-spacing: -0.02em;
            white-space: nowrap;
        }
        .nav-links { display: flex; gap: 4px; flex: 1; }
        .nav-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 8px;
            font-size: 13.5px;
            font-weight: 500;
            color: var(--text-secondary);
            text-decoration: none;
            transition: background 0.15s, color 0.15s;
        }
        .nav-link:hover { background: var(--bg); color: var(--text-primary); }
        .nav-link.active { background: var(--accent-light); color: var(--accent); }
        .nav-link i { font-size: 14px; }

        /* ── LAYOUT ── */
        .page { max-width: 1200px; margin: 0 auto; padding: 32px 24px; }

        .page-header {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            margin-bottom: 24px;
        }
        .page-title {
            font-size: 22px;
            font-weight: 700;
            color: var(--text-primary);
            letter-spacing: -0.03em;
        }
        .page-subtitle {
            font-size: 13px;
            color: var(--text-muted);
            margin-top: 2px;
        }

        /* ── SEARCH + ACTIONS ── */
        .toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 16px;
        }
        .search-wrap {
            position: relative;
            flex: 0 0 260px;
        }
        .search-wrap i {
            position: absolute;
            left: 11px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 14px;
        }
        .search-input {
            width: 100%;
            padding: 8px 12px 8px 34px;
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            font-size: 13.5px;
            font-family: inherit;
            background: var(--surface);
            color: var(--text-primary);
            outline: none;
            transition: border-color 0.15s, box-shadow 0.15s;
        }
        .search-input:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(79,70,229,0.1);
        }
        .search-input::placeholder { color: var(--text-muted); }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 8px 16px;
            border-radius: var(--radius-sm);
            font-size: 13.5px;
            font-weight: 500;
            font-family: inherit;
            cursor: pointer;
            border: none;
            transition: all 0.15s;
            text-decoration: none;
            line-height: 1;
        }
        .btn-primary {
            background: var(--accent);
            color: #fff;
            box-shadow: var(--shadow-sm);
        }
        .btn-primary:hover { background: var(--accent-hover); box-shadow: var(--shadow); }
        .btn-ghost {
            background: transparent;
            color: var(--text-secondary);
            border: 1px solid var(--border);
        }
        .btn-ghost:hover { background: var(--bg); color: var(--text-primary); }
        .btn-danger-ghost {
            background: transparent;
            color: var(--danger);
            border: 1px solid transparent;
        }
        .btn-danger-ghost:hover { background: var(--danger-light); border-color: #fca5a5; }
        .btn-sm { padding: 5px 10px; font-size: 12.5px; border-radius: 7px; }

        /* ── CARD / TABLE ── */
        .card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        table { width: 100%; border-collapse: collapse; }
        thead th {
            background: #fafafa;
            border-bottom: 1px solid var(--border);
            padding: 11px 16px;
            text-align: left;
            font-size: 11.5px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: var(--text-muted);
            white-space: nowrap;
        }
        tbody td {
            padding: 13px 16px;
            border-bottom: 1px solid var(--border-light);
            font-size: 13.5px;
            color: var(--text-primary);
            vertical-align: middle;
        }
        tbody tr:last-child td { border-bottom: none; }
        tbody tr { transition: background 0.12s; }
        tbody tr:hover { background: var(--surface-hover); }

        .thumb {
            width: 38px; height: 38px;
            border-radius: 8px;
            object-fit: cover;
            border: 1px solid var(--border);
            display: block;
        }
        .thumb-placeholder {
            width: 38px; height: 38px;
            border-radius: 8px;
            background: var(--bg);
            border: 1px solid var(--border);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: var(--text-muted);
        }
        .cat-name { font-weight: 500; }
        .row-id { color: var(--text-muted); font-variant-numeric: tabular-nums; }

        /* ── ACTIONS ── */
        .actions { display: flex; gap: 4px; }

        /* ── EMPTY STATE ── */
        .empty {
            padding: 64px 24px;
            text-align: center;
            color: var(--text-muted);
        }
        .empty-icon {
            width: 52px; height: 52px;
            background: var(--bg);
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            color: var(--text-muted);
            margin-bottom: 14px;
        }
        .empty h3 { font-size: 14px; font-weight: 600; color: var(--text-secondary); margin-bottom: 4px; }
        .empty p { font-size: 13px; }

        /* ── MODAL ── */
        .modal-overlay {
            position: fixed; inset: 0;
            background: rgba(17,24,39,0.4);
            backdrop-filter: blur(2px);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 500;
            opacity: 0; pointer-events: none;
            transition: opacity 0.2s;
        }
        .modal-overlay.open { opacity: 1; pointer-events: all; }
        .modal {
            background: var(--surface);
            border-radius: 16px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
            width: 440px;
            max-width: calc(100vw - 32px);
            transform: translateY(12px) scale(0.98);
            transition: transform 0.2s, opacity 0.2s;
            opacity: 0;
        }
        .modal-overlay.open .modal { transform: translateY(0) scale(1); opacity: 1; }
        .modal-head {
            padding: 20px 24px 16px;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .modal-title { font-size: 15px; font-weight: 600; letter-spacing: -0.01em; }
        .modal-close {
            width: 30px; height: 30px;
            display: flex; align-items: center; justify-content: center;
            border-radius: 6px;
            border: none;
            background: none;
            cursor: pointer;
            color: var(--text-muted);
            font-size: 16px;
            transition: background 0.15s, color 0.15s;
        }
        .modal-close:hover { background: var(--bg); color: var(--text-primary); }
        .modal-body { padding: 20px 24px; }
        .modal-foot {
            padding: 16px 24px;
            border-top: 1px solid var(--border);
            display: flex;
            justify-content: flex-end;
            gap: 8px;
        }

        .form-group { margin-bottom: 16px; }
        .form-group:last-child { margin-bottom: 0; }
        label {
            display: block;
            font-size: 12.5px;
            font-weight: 500;
            color: var(--text-secondary);
            margin-bottom: 6px;
        }
        .req { color: var(--danger); }
        .form-control {
            width: 100%;
            padding: 9px 12px;
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            font-size: 13.5px;
            font-family: inherit;
            color: var(--text-primary);
            background: var(--surface);
            outline: none;
            transition: border-color 0.15s, box-shadow 0.15s;
        }
        .form-control:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(79,70,229,0.1);
        }
        .form-hint {
            font-size: 11.5px;
            color: var(--text-muted);
            margin-top: 5px;
        }
        .current-icon-wrap { display: flex; align-items: center; gap: 10px; margin-bottom: 8px; }

        /* ── CONFIRM MODAL ── */
        .confirm-icon {
            width: 44px; height: 44px;
            background: var(--danger-light);
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 20px;
            color: var(--danger);
            margin-bottom: 12px;
        }
        .confirm-title { font-size: 15px; font-weight: 600; margin-bottom: 6px; }
        .confirm-desc { font-size: 13px; color: var(--text-secondary); line-height: 1.5; }
        .btn-danger { background: var(--danger); color: #fff; }
        .btn-danger:hover { background: #dc2626; }

        /* ── TOAST ── */
        #toasts {
            position: fixed; top: 20px; right: 20px;
            z-index: 9999;
            display: flex; flex-direction: column; gap: 8px;
        }
        .toast {
            display: flex; align-items: center; gap: 10px;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 10px;
            padding: 12px 16px;
            font-size: 13.5px;
            box-shadow: var(--shadow-md);
            min-width: 260px;
            animation: slideIn 0.2s ease;
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

        /* ── BADGE ── */
        .count-badge {
            display: inline-flex; align-items: center; justify-content: center;
            background: var(--accent-light);
            color: var(--accent);
            font-size: 11px;
            font-weight: 600;
            padding: 1px 8px;
            border-radius: 20px;
            margin-left: 8px;
        }
    </style>
</head>
<body>

<div class="topbar">
    <div class="topbar-inner">
        <span class="brand">Management</span>
        <nav class="nav-links">
            <a href="/categories" class="nav-link active">
                <i class="bi bi-tag"></i> Categories
            </a>
            <a href="/products" class="nav-link">
                <i class="bi bi-box"></i> Products
            </a>
            <a href="/swagger-ui/index.html" class="nav-link" target="_blank">
                <i class="bi bi-braces"></i> API Docs
            </a>
        </nav>
    </div>
</div>

<div id="toasts"></div>

<div class="page">
    <div class="page-header">
        <div>
            <h1 class="page-title">Categories <span class="count-badge" id="countBadge">0</span></h1>
            <p class="page-subtitle">Manage and organise product categories</p>
        </div>
        <button class="btn btn-primary" onclick="openAdd()">
            <i class="bi bi-plus-lg"></i> New Category
        </button>
    </div>

    <div class="toolbar">
        <div class="search-wrap">
            <i class="bi bi-search"></i>
            <input type="text" class="search-input" id="searchInput" placeholder="Filter categories…">
        </div>
    </div>

    <div class="card">
        <table>
            <thead>
            <tr>
                <th style="width:48px">#</th>
                <th style="width:60px">Icon</th>
                <th>Category Name</th>
                <th style="width:130px">Actions</th>
            </tr>
            </thead>
            <tbody id="tbody">
            <tr><td colspan="4"><div class="empty"><div class="empty-icon"><i class="bi bi-arrow-repeat spin"></i></div><p>Loading…</p></div></td></tr>
            </tbody>
        </table>
    </div>
</div>

<!-- ADD MODAL -->
<div class="modal-overlay" id="addOverlay">
    <div class="modal">
        <div class="modal-head">
            <span class="modal-title">New Category</span>
            <button class="modal-close" onclick="closeAdd()"><i class="bi bi-x"></i></button>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label>Category Name <span class="req">*</span></label>
                <input type="text" id="add-name" class="form-control" placeholder="e.g. Electronics">
            </div>
            <div class="form-group">
                <label>Icon Image</label>
                <input type="file" id="add-icon" class="form-control" accept="image/*">
                <p class="form-hint">PNG, JPG or WEBP, max 5 MB. Optional.</p>
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
            <span class="modal-title">Edit Category</span>
            <button class="modal-close" onclick="closeEdit()"><i class="bi bi-x"></i></button>
        </div>
        <div class="modal-body">
            <input type="hidden" id="edit-id">
            <div class="form-group">
                <label>Category Name <span class="req">*</span></label>
                <input type="text" id="edit-name" class="form-control">
            </div>
            <div class="form-group">
                <label>Current Icon</label>
                <div class="current-icon-wrap" id="edit-current-icon"></div>
                <label>Replace Icon</label>
                <input type="file" id="edit-icon" class="form-control" accept="image/*">
                <p class="form-hint">Leave empty to keep existing icon.</p>
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
            <p class="confirm-title">Delete Category?</p>
            <p class="confirm-desc">You're about to delete <strong id="del-name"></strong>. This action cannot be undone.</p>
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
    let allCats = [];

    const addOv = document.getElementById('addOverlay');
    const editOv = document.getElementById('editOverlay');
    const delOv = document.getElementById('delOverlay');

    function openModal(ov) { ov.classList.add('open'); }
    function closeModal(ov) { ov.classList.remove('open'); }
    function openAdd() { document.getElementById('add-name').value = ''; document.getElementById('add-icon').value = ''; openModal(addOv); }
    function closeAdd() { closeModal(addOv); }
    function closeEdit() { closeModal(editOv); }
    function closeDel() { closeModal(delOv); }

    addOv.addEventListener('click', e => { if (e.target === addOv) closeAdd(); });
    editOv.addEventListener('click', e => { if (e.target === editOv) closeEdit(); });
    delOv.addEventListener('click', e => { if (e.target === delOv) closeDel(); });

    function toast(msg, type) {
        const c = document.getElementById('toasts');
        const el = document.createElement('div');
        el.className = 'toast toast-' + type;
        el.innerHTML = (type === 'success' ? '<i class="bi bi-check-circle-fill"></i>' : '<i class="bi bi-x-circle-fill"></i>') + '<span>' + esc(msg) + '</span>';
        c.prepend(el);
        setTimeout(() => el.remove(), 3800);
    }

    function esc(s) { return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;'); }

    function render(list) {
        const tbody = document.getElementById('tbody');
        document.getElementById('countBadge').textContent = list.length;
        if (!list.length) {
            tbody.innerHTML = '<tr><td colspan="4"><div class="empty"><div class="empty-icon"><i class="bi bi-tag"></i></div><h3>No categories yet</h3><p>Click "New Category" to get started.</p></div></td></tr>';
            return;
        }
        tbody.innerHTML = list.map((c, i) => `
            <tr>
                <td class="row-id">${i+1}</td>
                <td>${c.icon ? `<img src="/uploads/${esc(c.icon)}" class="thumb" alt="">` : `<span class="thumb-placeholder"><i class="bi bi-image"></i></span>`}</td>
                <td><span class="cat-name">${esc(c.categoryName)}</span></td>
                <td><div class="actions">
                    <button class="btn btn-ghost btn-sm" onclick="openEdit(${c.categoryId})"><i class="bi bi-pencil"></i> Edit</button>
                    <button class="btn btn-danger-ghost btn-sm" onclick="openDel(${c.categoryId},'${esc(c.categoryName)}')"><i class="bi bi-trash3"></i></button>
                </div></td>
            </tr>`).join('');
    }

    function load() {
        $.get('/api/category', res => {
            allCats = res.body || [];
            render(allCats);
        }).fail(() => toast('Failed to load categories', 'error'));
    }

    document.getElementById('searchInput').addEventListener('input', function() {
        const q = this.value.toLowerCase();
        render(allCats.filter(c => c.categoryName.toLowerCase().includes(q)));
    });

    function submitAdd() {
        const name = $('#add-name').val().trim();
        if (!name) { toast('Category name is required', 'error'); return; }
        const fd = new FormData();
        fd.append('categoryName', name);
        const f = $('#add-icon')[0].files[0]; if (f) fd.append('icon', f);
        $.ajax({ url:'/api/category/addCategory', method:'POST', data:fd, processData:false, contentType:false,
            success(r) { if(r.status){toast('Category added','success');closeAdd();load();}else toast(r.message,'error'); },
            error(x){toast(x.responseJSON?.message||'Error','error');}
        });
    }

    function openEdit(id) {
        $.ajax({url:'/api/category/getCategory',method:'POST',data:{id},
            success(r){
                if(!r.status){toast(r.message,'error');return;}
                const c=r.body;
                $('#edit-id').val(c.categoryId); $('#edit-name').val(c.categoryName); $('#edit-icon').val('');
                const d=$('#edit-current-icon');
                d.html(c.icon?`<img src="/uploads/${esc(c.icon)}" class="thumb" alt=""><span style="font-size:12px;color:var(--text-muted)">${esc(c.icon)}</span>`:'<span style="font-size:12px;color:var(--text-muted)">No icon</span>');
                openModal(editOv);
            },error(){toast('Failed to load','error');}
        });
    }

    function submitEdit() {
        const id=$('#edit-id').val(), name=$('#edit-name').val().trim();
        if(!name){toast('Name is required','error');return;}
        const fd=new FormData(); fd.append('categoryId',id); fd.append('categoryName',name);
        const f=$('#edit-icon')[0].files[0]; if(f) fd.append('icon',f);
        $.ajax({url:'/api/category/updateCategory',method:'PUT',data:fd,processData:false,contentType:false,
            success(r){if(r.status){toast('Category updated','success');closeEdit();load();}else toast(r.message,'error');},
            error(x){toast(x.responseJSON?.message||'Error','error');}
        });
    }

    function openDel(id,name) { $('#del-id').val(id); document.getElementById('del-name').textContent=name; openModal(delOv); }
    function submitDel() {
        $.ajax({url:'/api/category/deleteCategory',method:'DELETE',data:{categoryId:$('#del-id').val()},
            success(r){if(r.status){toast('Deleted','success');closeDel();load();}else toast(r.message,'error');},
            error(x){toast(x.responseJSON?.message||'Error','error');}
        });
    }

    $(load);
</script>
</body>
</html>
