<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category Management</title>
    <meta name="description" content="Manage product categories">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        :root {
            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --surface: #ffffff;
            --surface-alt: #f8fafc;
            --border: #e2e8f0;
            --text: #1e293b;
            --text-muted: #64748b;
            --danger: #dc2626;
        }
        * { box-sizing: border-box; }
        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background: var(--surface-alt);
            color: var(--text);
            margin: 0;
        }
        .navbar {
            background: var(--surface);
            border-bottom: 1px solid var(--border);
            padding: 0.75rem 1.5rem;
        }
        .navbar-brand {
            font-weight: 700;
            font-size: 1.05rem;
            color: var(--text) !important;
            letter-spacing: -0.01em;
        }
        .nav-link {
            color: var(--text-muted) !important;
            font-size: 0.875rem;
            font-weight: 500;
            padding: 0.4rem 0.8rem !important;
            border-radius: 6px;
            transition: background 0.15s, color 0.15s;
        }
        .nav-link:hover, .nav-link.active {
            background: #f1f5f9;
            color: var(--text) !important;
        }
        .main-content {
            max-width: 1100px;
            margin: 0 auto;
            padding: 2rem 1.5rem;
        }
        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
        }
        .page-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text);
            margin: 0;
        }
        .btn-primary-custom {
            background: var(--primary);
            color: #fff;
            border: none;
            padding: 0.5rem 1.1rem;
            border-radius: 8px;
            font-size: 0.875rem;
            font-weight: 500;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
        }
        .btn-primary-custom:hover { background: var(--primary-dark); color: #fff; }
        .card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        .table { margin: 0; font-size: 0.875rem; }
        .table thead th {
            background: var(--surface-alt);
            border-bottom: 1px solid var(--border);
            color: var(--text-muted);
            font-weight: 600;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.03em;
            padding: 0.8rem 1rem;
        }
        .table tbody td {
            padding: 0.85rem 1rem;
            border-bottom: 1px solid var(--border);
            vertical-align: middle;
        }
        .table tbody tr:last-child td { border-bottom: none; }
        .table tbody tr:hover { background: #f8fafc; }
        .icon-thumb {
            width: 40px;
            height: 40px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid var(--border);
        }
        .icon-placeholder {
            width: 40px;
            height: 40px;
            background: var(--surface-alt);
            border: 1px solid var(--border);
            border-radius: 8px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: var(--text-muted);
            font-size: 1rem;
        }
        .action-btn {
            background: none;
            border: 1px solid var(--border);
            border-radius: 6px;
            padding: 0.3rem 0.6rem;
            font-size: 0.8rem;
            cursor: pointer;
            transition: all 0.15s;
        }
        .action-btn-edit { color: var(--primary); }
        .action-btn-edit:hover { background: #eff6ff; border-color: var(--primary); }
        .action-btn-delete { color: var(--danger); }
        .action-btn-delete:hover { background: #fef2f2; border-color: var(--danger); }
        .modal-header { border-bottom: 1px solid var(--border); padding: 1.25rem 1.5rem; }
        .modal-footer { border-top: 1px solid var(--border); padding: 1rem 1.5rem; }
        .modal-title { font-weight: 600; font-size: 1rem; }
        .form-label { font-size: 0.875rem; font-weight: 500; color: var(--text); margin-bottom: 0.4rem; }
        .form-control, .form-select {
            font-size: 0.875rem;
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 0.5rem 0.75rem;
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37,99,235,0.1);
        }
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: var(--text-muted);
        }
        .empty-state i { font-size: 2.5rem; margin-bottom: 0.75rem; display: block; }
        #toast-container {
            position: fixed;
            top: 1.25rem;
            right: 1.25rem;
            z-index: 9999;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        .toast-msg {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 10px;
            padding: 0.85rem 1.1rem;
            font-size: 0.875rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            display: flex;
            align-items: center;
            gap: 0.6rem;
            min-width: 280px;
        }
        .toast-success { border-left: 3px solid #16a34a; }
        .toast-error { border-left: 3px solid var(--danger); }
    </style>
</head>
<body>
<nav class="navbar">
    <div class="d-flex align-items-center gap-4 w-100">
        <span class="navbar-brand">Product Management</span>
        <div class="d-flex gap-1">
            <a href="/categories" class="nav-link active">Categories</a>
            <a href="/products" class="nav-link">Products</a>
            <a href="/swagger-ui/index.html" class="nav-link" target="_blank">API Docs</a>
        </div>
    </div>
</nav>

<div id="toast-container"></div>

<div class="main-content">
    <div class="page-header">
        <h1 class="page-title">Categories</h1>
        <button class="btn-primary-custom" onclick="openAddModal()">
            <i class="bi bi-plus-lg"></i> Add Category
        </button>
    </div>

    <div class="card">
        <table class="table" id="categoryTable">
            <thead>
            <tr>
                <th>#</th>
                <th>Icon</th>
                <th>Category Name</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="categoryTableBody">
            <tr>
                <td colspan="4" class="text-center text-muted py-4">Loading...</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<!-- Add Modal -->
<div class="modal fade" id="addModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Add Category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">
                <form id="addForm" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label class="form-label">Category Name <span class="text-danger">*</span></label>
                        <input type="text" id="add-categoryName" class="form-control" placeholder="Enter category name" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Icon (optional)</label>
                        <input type="file" id="add-icon" class="form-control" accept="image/*">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-sm btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-sm btn-primary" onclick="submitAdd()">Add Category</button>
            </div>
        </div>
    </div>
</div>

<!-- Edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">
                <form id="editForm" enctype="multipart/form-data">
                    <input type="hidden" id="edit-categoryId">
                    <div class="mb-3">
                        <label class="form-label">Category Name <span class="text-danger">*</span></label>
                        <input type="text" id="edit-categoryName" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Current Icon</label>
                        <div id="edit-currentIcon" class="mb-2"></div>
                        <label class="form-label text-muted" style="font-size:0.8rem;">Upload new icon to replace (leave empty to keep current)</label>
                        <input type="file" id="edit-icon" class="form-control" accept="image/*">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-sm btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-sm btn-primary" onclick="submitEdit()">Save Changes</button>
            </div>
        </div>
    </div>
</div>

<!-- Delete Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Delete Category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">
                <p class="mb-0">Are you sure you want to delete <strong id="delete-categoryName"></strong>?</p>
                <input type="hidden" id="delete-categoryId">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-sm btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-sm btn-danger" onclick="submitDelete()">Delete</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    const addModal = new bootstrap.Modal(document.getElementById('addModal'));
    const editModal = new bootstrap.Modal(document.getElementById('editModal'));
    const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));

    function showToast(msg, type) {
        const container = document.getElementById('toast-container');
        const el = document.createElement('div');
        el.className = 'toast-msg ' + (type === 'success' ? 'toast-success' : 'toast-error');
        el.innerHTML = '<i class="bi ' + (type === 'success' ? 'bi-check-circle text-success' : 'bi-x-circle text-danger') + '"></i>' + msg;
        container.appendChild(el);
        setTimeout(() => el.remove(), 3500);
    }

    function loadCategories() {
        $.ajax({
            url: '/api/category',
            method: 'GET',
            success: function(res) {
                const tbody = $('#categoryTableBody');
                tbody.empty();
                if (!res.body || res.body.length === 0) {
                    tbody.append('<tr><td colspan="4"><div class="empty-state"><i class="bi bi-tag"></i>No categories yet</div></td></tr>');
                    return;
                }
                $.each(res.body, function(i, cat) {
                    const iconHtml = cat.icon
                        ? '<img src="/uploads/' + cat.icon + '" class="icon-thumb" alt="icon">'
                        : '<span class="icon-placeholder"><i class="bi bi-tag"></i></span>';
                    tbody.append('<tr>' +
                        '<td class="text-muted">' + (i + 1) + '</td>' +
                        '<td>' + iconHtml + '</td>' +
                        '<td><span style="font-weight:500">' + escHtml(cat.categoryName) + '</span></td>' +
                        '<td>' +
                        '<button class="action-btn action-btn-edit me-1" onclick="openEditModal(' + cat.categoryId + ')"><i class="bi bi-pencil"></i> Edit</button>' +
                        '<button class="action-btn action-btn-delete" onclick="openDeleteModal(' + cat.categoryId + ', \'' + escHtml(cat.categoryName) + '\')"><i class="bi bi-trash"></i> Delete</button>' +
                        '</td>' +
                        '</tr>');
                });
            },
            error: function() { showToast('Failed to load categories', 'error'); }
        });
    }

    function escHtml(str) {
        return String(str).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
    }

    function openAddModal() {
        document.getElementById('addForm').reset();
        addModal.show();
    }

    function submitAdd() {
        const name = $('#add-categoryName').val().trim();
        if (!name) { showToast('Category name is required', 'error'); return; }
        const fd = new FormData();
        fd.append('categoryName', name);
        const iconFile = $('#add-icon')[0].files[0];
        if (iconFile) fd.append('icon', iconFile);

        $.ajax({
            url: '/api/category/addCategory',
            method: 'POST',
            data: fd,
            processData: false,
            contentType: false,
            success: function(res) {
                if (res.status) {
                    showToast('Category added successfully', 'success');
                    addModal.hide();
                    loadCategories();
                } else {
                    showToast(res.message, 'error');
                }
            },
            error: function(xhr) {
                const msg = xhr.responseJSON ? xhr.responseJSON.message : 'Failed to add category';
                showToast(msg, 'error');
            }
        });
    }

    function openEditModal(id) {
        $.ajax({
            url: '/api/category/getCategory',
            method: 'POST',
            data: { id: id },
            success: function(res) {
                if (!res.status) { showToast(res.message, 'error'); return; }
                const cat = res.body;
                $('#edit-categoryId').val(cat.categoryId);
                $('#edit-categoryName').val(cat.categoryName);
                $('#edit-icon').val('');
                const iconDiv = $('#edit-currentIcon');
                if (cat.icon) {
                    iconDiv.html('<img src="/uploads/' + cat.icon + '" class="icon-thumb" alt="current icon">');
                } else {
                    iconDiv.html('<span class="text-muted" style="font-size:0.8rem">No icon</span>');
                }
                editModal.show();
            },
            error: function() { showToast('Failed to load category', 'error'); }
        });
    }

    function submitEdit() {
        const id = $('#edit-categoryId').val();
        const name = $('#edit-categoryName').val().trim();
        if (!name) { showToast('Category name is required', 'error'); return; }
        const fd = new FormData();
        fd.append('categoryId', id);
        fd.append('categoryName', name);
        const iconFile = $('#edit-icon')[0].files[0];
        if (iconFile) fd.append('icon', iconFile);

        $.ajax({
            url: '/api/category/updateCategory',
            method: 'PUT',
            data: fd,
            processData: false,
            contentType: false,
            success: function(res) {
                if (res.status) {
                    showToast('Category updated successfully', 'success');
                    editModal.hide();
                    loadCategories();
                } else {
                    showToast(res.message, 'error');
                }
            },
            error: function(xhr) {
                const msg = xhr.responseJSON ? xhr.responseJSON.message : 'Failed to update category';
                showToast(msg, 'error');
            }
        });
    }

    function openDeleteModal(id, name) {
        $('#delete-categoryId').val(id);
        $('#delete-categoryName').text(name);
        deleteModal.show();
    }

    function submitDelete() {
        const id = $('#delete-categoryId').val();
        $.ajax({
            url: '/api/category/deleteCategory',
            method: 'DELETE',
            data: { categoryId: id },
            success: function(res) {
                if (res.status) {
                    showToast('Category deleted', 'success');
                    deleteModal.hide();
                    loadCategories();
                } else {
                    showToast(res.message, 'error');
                }
            },
            error: function(xhr) {
                const msg = xhr.responseJSON ? xhr.responseJSON.message : 'Failed to delete category';
                showToast(msg, 'error');
            }
        });
    }

    $(document).ready(function() { loadCategories(); });
</script>
</body>
</html>
