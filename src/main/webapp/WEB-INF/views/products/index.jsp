<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management</title>
    <meta name="description" content="Manage products">
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
            max-width: 1300px;
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
            white-space: nowrap;
        }
        .table tbody td {
            padding: 0.85rem 1rem;
            border-bottom: 1px solid var(--border);
            vertical-align: middle;
        }
        .table tbody tr:last-child td { border-bottom: none; }
        .table tbody tr:hover { background: #f8fafc; }
        .img-thumb {
            width: 48px;
            height: 48px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid var(--border);
        }
        .img-placeholder {
            width: 48px;
            height: 48px;
            background: var(--surface-alt);
            border: 1px solid var(--border);
            border-radius: 8px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: var(--text-muted);
            font-size: 1.1rem;
        }
        .status-badge {
            display: inline-block;
            padding: 0.2rem 0.6rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        .status-active { background: #dcfce7; color: #166534; }
        .status-inactive { background: #fee2e2; color: #991b1b; }
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
            <a href="/categories" class="nav-link">Categories</a>
            <a href="/products" class="nav-link active">Products</a>
            <a href="/swagger-ui/index.html" class="nav-link" target="_blank">API Docs</a>
        </div>
    </div>
</nav>

<div id="toast-container"></div>

<div class="main-content">
    <div class="page-header">
        <h1 class="page-title">Products</h1>
        <button class="btn-primary-custom" onclick="openAddModal()">
            <i class="bi bi-plus-lg"></i> Add Product
        </button>
    </div>

    <div class="card">
        <div style="overflow-x:auto;">
            <table class="table" id="productTable">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Image</th>
                    <th>Product Name</th>
                    <th>Category</th>
                    <th>Unit Price</th>
                    <th>Discount</th>
                    <th>Quantity</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody id="productTableBody">
                <tr><td colspan="9" class="text-center text-muted py-4">Loading...</td></tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Add Modal -->
<div class="modal fade" id="addModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Add Product</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Product Name <span class="text-danger">*</span></label>
                        <input type="text" id="add-productName" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Category <span class="text-danger">*</span></label>
                        <select id="add-categoryId" class="form-select" required>
                            <option value="">Select category</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Unit Price <span class="text-danger">*</span></label>
                        <input type="number" id="add-unitPrice" class="form-control" min="0" step="0.01" value="0">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Discount (%)</label>
                        <input type="number" id="add-discount" class="form-control" min="0" max="100" step="0.01" value="0">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Quantity</label>
                        <input type="number" id="add-quantity" class="form-control" min="0" value="0">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Status</label>
                        <select id="add-status" class="form-select">
                            <option value="1">Active</option>
                            <option value="0">Inactive</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Image</label>
                        <input type="file" id="add-imageFile" class="form-control" accept="image/*">
                    </div>
                    <div class="col-12">
                        <label class="form-label">Description</label>
                        <textarea id="add-description" class="form-control" rows="3" placeholder="Optional description"></textarea>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-sm btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-sm btn-primary" onclick="submitAdd()">Add Product</button>
            </div>
        </div>
    </div>
</div>

<!-- Edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Product</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">
                <input type="hidden" id="edit-productId">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Product Name <span class="text-danger">*</span></label>
                        <input type="text" id="edit-productName" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Category <span class="text-danger">*</span></label>
                        <select id="edit-categoryId" class="form-select" required>
                            <option value="">Select category</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Unit Price <span class="text-danger">*</span></label>
                        <input type="number" id="edit-unitPrice" class="form-control" min="0" step="0.01">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Discount (%)</label>
                        <input type="number" id="edit-discount" class="form-control" min="0" max="100" step="0.01">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Quantity</label>
                        <input type="number" id="edit-quantity" class="form-control" min="0">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Status</label>
                        <select id="edit-status" class="form-select">
                            <option value="1">Active</option>
                            <option value="0">Inactive</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Current Image</label>
                        <div id="edit-currentImage" class="mb-1"></div>
                        <label class="form-label text-muted" style="font-size:0.8rem">Upload new image to replace</label>
                        <input type="file" id="edit-imageFile" class="form-control" accept="image/*">
                    </div>
                    <div class="col-12">
                        <label class="form-label">Description</label>
                        <textarea id="edit-description" class="form-control" rows="3"></textarea>
                    </div>
                </div>
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
                <h5 class="modal-title">Delete Product</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">
                <p class="mb-0">Delete <strong id="delete-productName"></strong>?</p>
                <input type="hidden" id="delete-productId">
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
        el.innerHTML = '<i class="bi ' + (type === 'success' ? 'bi-check-circle text-success' : 'bi-x-circle text-danger') + '"></i>' + escHtml(msg);
        container.appendChild(el);
        setTimeout(() => el.remove(), 3500);
    }

    function escHtml(str) {
        return String(str).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
    }

    function fmt(val, decimals) {
        return Number(val || 0).toFixed(decimals || 0);
    }

    function loadProducts() {
        $.ajax({
            url: '/api/product',
            method: 'GET',
            success: function(res) {
                const tbody = $('#productTableBody');
                tbody.empty();
                if (!res.body || res.body.length === 0) {
                    tbody.append('<tr><td colspan="9"><div class="empty-state"><i class="bi bi-box"></i>No products yet</div></td></tr>');
                    return;
                }
                $.each(res.body, function(i, p) {
                    const imgHtml = p.images
                        ? '<img src="/uploads/' + p.images + '" class="img-thumb" alt="img">'
                        : '<span class="img-placeholder"><i class="bi bi-image"></i></span>';
                    const catName = p.category ? escHtml(p.category.categoryName) : '<span class="text-muted">—</span>';
                    const statusHtml = p.status == 1
                        ? '<span class="status-badge status-active">Active</span>'
                        : '<span class="status-badge status-inactive">Inactive</span>';
                    tbody.append('<tr>' +
                        '<td class="text-muted">' + (i + 1) + '</td>' +
                        '<td>' + imgHtml + '</td>' +
                        '<td style="font-weight:500">' + escHtml(p.productName) + '</td>' +
                        '<td>' + catName + '</td>' +
                        '<td>' + fmt(p.unitPrice, 2) + '</td>' +
                        '<td>' + fmt(p.discount, 1) + '%</td>' +
                        '<td>' + (p.quantity || 0) + '</td>' +
                        '<td>' + statusHtml + '</td>' +
                        '<td>' +
                        '<button class="action-btn action-btn-edit me-1" onclick="openEditModal(' + p.productId + ')"><i class="bi bi-pencil"></i> Edit</button>' +
                        '<button class="action-btn action-btn-delete" onclick="openDeleteModal(' + p.productId + ', \'' + escHtml(p.productName) + '\')"><i class="bi bi-trash"></i></button>' +
                        '</td>' +
                        '</tr>');
                });
            },
            error: function() { showToast('Failed to load products', 'error'); }
        });
    }

    function loadCategoriesToSelect(selectId, selectedCatId) {
        $.ajax({
            url: '/api/category',
            method: 'GET',
            success: function(res) {
                const sel = $('#' + selectId);
                sel.empty().append('<option value="">Select category</option>');
                if (res.body) {
                    $.each(res.body, function(i, cat) {
                        const opt = $('<option>').val(cat.categoryId).text(cat.categoryName);
                        if (selectedCatId && cat.categoryId == selectedCatId) opt.prop('selected', true);
                        sel.append(opt);
                    });
                }
            }
        });
    }

    function openAddModal() {
        $('#add-productName').val('');
        $('#add-unitPrice').val(0);
        $('#add-discount').val(0);
        $('#add-quantity').val(0);
        $('#add-status').val(1);
        $('#add-description').val('');
        $('#add-imageFile').val('');
        loadCategoriesToSelect('add-categoryId', null);
        addModal.show();
    }

    function submitAdd() {
        const name = $('#add-productName').val().trim();
        const catId = $('#add-categoryId').val();
        const price = $('#add-unitPrice').val();
        if (!name) { showToast('Product name is required', 'error'); return; }
        if (!catId) { showToast('Please select a category', 'error'); return; }

        const fd = new FormData();
        fd.append('productName', name);
        fd.append('categoryId', catId);
        fd.append('unitPrice', price || 0);
        fd.append('discount', $('#add-discount').val() || 0);
        fd.append('quantity', $('#add-quantity').val() || 0);
        fd.append('status', $('#add-status').val());
        fd.append('description', $('#add-description').val());
        const imgFile = $('#add-imageFile')[0].files[0];
        if (imgFile) fd.append('imageFile', imgFile);

        $.ajax({
            url: '/api/product/addProduct',
            method: 'POST',
            data: fd,
            processData: false,
            contentType: false,
            success: function(res) {
                if (res.status) {
                    showToast('Product added successfully', 'success');
                    addModal.hide();
                    loadProducts();
                } else { showToast(res.message, 'error'); }
            },
            error: function(xhr) {
                showToast(xhr.responseJSON ? xhr.responseJSON.message : 'Failed to add product', 'error');
            }
        });
    }

    function openEditModal(id) {
        $.ajax({
            url: '/api/product/getProduct',
            method: 'POST',
            data: { id: id },
            success: function(res) {
                if (!res.status) { showToast(res.message, 'error'); return; }
                const p = res.body;
                $('#edit-productId').val(p.productId);
                $('#edit-productName').val(p.productName);
                $('#edit-unitPrice').val(p.unitPrice);
                $('#edit-discount').val(p.discount || 0);
                $('#edit-quantity').val(p.quantity || 0);
                $('#edit-status').val(p.status);
                $('#edit-description').val(p.description || '');
                $('#edit-imageFile').val('');
                const imgDiv = $('#edit-currentImage');
                if (p.images) {
                    imgDiv.html('<img src="/uploads/' + p.images + '" class="img-thumb">');
                } else {
                    imgDiv.html('<span class="text-muted" style="font-size:0.8rem">No image</span>');
                }
                loadCategoriesToSelect('edit-categoryId', p.category ? p.category.categoryId : null);
                editModal.show();
            },
            error: function() { showToast('Failed to load product', 'error'); }
        });
    }

    function submitEdit() {
        const id = $('#edit-productId').val();
        const name = $('#edit-productName').val().trim();
        const catId = $('#edit-categoryId').val();
        if (!name) { showToast('Product name is required', 'error'); return; }
        if (!catId) { showToast('Please select a category', 'error'); return; }

        const fd = new FormData();
        fd.append('productId', id);
        fd.append('productName', name);
        fd.append('categoryId', catId);
        fd.append('unitPrice', $('#edit-unitPrice').val() || 0);
        fd.append('discount', $('#edit-discount').val() || 0);
        fd.append('quantity', $('#edit-quantity').val() || 0);
        fd.append('status', $('#edit-status').val());
        fd.append('description', $('#edit-description').val());
        const imgFile = $('#edit-imageFile')[0].files[0];
        if (imgFile) fd.append('imageFile', imgFile);

        $.ajax({
            url: '/api/product/updateProduct',
            method: 'PUT',
            data: fd,
            processData: false,
            contentType: false,
            success: function(res) {
                if (res.status) {
                    showToast('Product updated successfully', 'success');
                    editModal.hide();
                    loadProducts();
                } else { showToast(res.message, 'error'); }
            },
            error: function(xhr) {
                showToast(xhr.responseJSON ? xhr.responseJSON.message : 'Failed to update product', 'error');
            }
        });
    }

    function openDeleteModal(id, name) {
        $('#delete-productId').val(id);
        $('#delete-productName').text(name);
        deleteModal.show();
    }

    function submitDelete() {
        const id = $('#delete-productId').val();
        $.ajax({
            url: '/api/product/deleteProduct',
            method: 'DELETE',
            data: { productId: id },
            success: function(res) {
                if (res.status) {
                    showToast('Product deleted', 'success');
                    deleteModal.hide();
                    loadProducts();
                } else { showToast(res.message, 'error'); }
            },
            error: function(xhr) {
                showToast(xhr.responseJSON ? xhr.responseJSON.message : 'Failed to delete product', 'error');
            }
        });
    }

    $(document).ready(function() { loadProducts(); });
</script>
</body>
</html>
