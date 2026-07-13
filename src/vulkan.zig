const std = @import("std");
const assert = std.debug.assert;

// vulkan_core.h
const ApiVersion = packed struct(u32) {
    patch: u12,
    minor: u10,
    major: u7,
    variant: u3,

    fn make(variant: u3, major: u7, minor: u10, patch: u12) ApiVersion { // 62
        return .{
            .variant = variant,
            .major = major,
            .minor = minor,
            .patch = patch,
        };
    }

    pub const @"1_0" = make(0, 1, 0, 0); // 92
};

const Version = packed struct(u32) {
    patch: u12,
    minor: u10,
    major: u10,

    pub fn make(major: u10, minor: u10, patch: u12) Version { // 75
        return .{
            .major = major,
            .minor = minor,
            .patch = patch,
        };
    }
};

pub const Bool32 = enum(u32) { // 94
    false = 0,
    true = 1,
};

const Flags = u32; // 97

const InstanceImpl = opaque { // 101
    extern fn vkDestroyInstance( // 4570
        instance: Instance,
        allocator: ?*const AllocationCallbacks,
    ) void;
    pub const deinit = vkDestroyInstance;

    extern fn vkCreateInstance( // 5100
        create_info: *const InstanceCreateInfo,
        allocator: ?*const AllocationCallbacks,
        instance: *Instance,
    ) Result;
    pub fn init(
        create_info: *const InstanceCreateInfo,
        allocator: ?*const AllocationCallbacks,
    ) Instance {
        var self: Instance = undefined;
        if (vkCreateInstance(create_info, allocator, &self) != .success) unreachable; // todo
        return self;
    }
};
pub const Instance = *InstanceImpl;

const max_extension_name_size = 256; // 134

const Result = enum(c_int) { // 140
    success = 0, // 141
};

const StructureType = enum(c_uint) { // 206
    application_info = 0, // 207
    instance_create_info = 1,
    device_queue_create_info = 2,
    device_create_info = 3,
    submit_info = 4,
    memory_allocate_info = 5,
    mapped_memory_range = 6,
    bind_sparse_info = 7,
    fence_create_info = 8,
    semaphore_create_info = 9,
    event_create_info = 10,
    query_pool_create_info = 11,
    buffer_create_info = 12,
    buffer_view_create_info = 13,
    image_create_info = 14,
    image_view_create_info = 15,
    shader_module_create_info = 16,
    pipeline_cache_create_info = 17,
    pipeline_shader_stage_create_info = 18,
    pipeline_vertex_input_state_create_info = 19,
    pipeline_input_assembly_state_create_info = 20,
    pipeline_tessellation_state_create_info = 21,
    pipeline_viewport_state_create_info = 22,
    pipeline_rasterization_state_create_info = 23,
    pipeline_multisample_state_create_info = 24,
    pipeline_depth_stencil_state_create_info = 25,
    pipeline_color_blend_state_create_info = 26,
    pipeline_dynamic_state_create_info = 27,
    graphics_pipeline_create_info = 28,
    compute_pipeline_create_info = 29,
    pipeline_layout_create_info = 30,
    sampler_create_info = 31,
    descriptor_set_layout_create_info = 32,
    descriptor_pool_create_info = 33,
    descriptor_set_allocate_info = 34,
    write_descriptor_set = 35,
    copy_descriptor_set = 36,
    framebuffer_create_info = 37,
    render_pass_create_info = 38,
    command_pool_create_info = 39,
    command_buffer_allocate_info = 40,
    command_buffer_inheritance_info = 41,
    command_buffer_begin_info = 42,
    render_pass_begin_info = 43,
    buffer_memory_barrier = 44,
    image_memory_barrier = 45,
    memory_barrier = 46,
    loader_instance_create_info = 47,
    loader_device_create_info = 48,
    bind_buffer_memory_info = 1000157000,
    bind_image_memory_info = 1000157001,
    memory_dedicated_requirements = 1000127000,
    memory_dedicated_allocate_info = 1000127001,
    memory_allocate_flags_info = 1000060000,
    device_group_command_buffer_begin_info = 1000060004,
    device_group_submit_info = 1000060005,
    device_group_bind_sparse_info = 1000060006,
    bind_buffer_memory_device_group_info = 1000060013,
    bind_image_memory_device_group_info = 1000060014,
    physical_device_group_properties = 1000070000,
    device_group_device_create_info = 1000070001,
    buffer_memory_requirements_info_2 = 1000146000,
    image_memory_requirements_info_2 = 1000146001,
    image_sparse_memory_requirements_info_2 = 1000146002,
    memory_requirements_2 = 1000146003,
    sparse_image_memory_requirements_2 = 1000146004,
    physical_device_features_2 = 1000059000,
    physical_device_properties_2 = 1000059001,
    format_properties_2 = 1000059002,
    image_format_properties_2 = 1000059003,
    physical_device_image_format_info_2 = 1000059004,
    queue_family_properties_2 = 1000059005,
    physical_device_memory_properties_2 = 1000059006,
    sparse_image_format_properties_2 = 1000059007,
    physical_device_sparse_image_format_info_2 = 1000059008,
    image_view_usage_create_info = 1000117002,
    protected_submit_info = 1000145000,
    physical_device_protected_memory_features = 1000145001,
    physical_device_protected_memory_properties = 1000145002,
    device_queue_info_2 = 1000145003,
    physical_device_external_image_format_info = 1000071000,
    external_image_format_properties = 1000071001,
    physical_device_external_buffer_info = 1000071002,
    external_buffer_properties = 1000071003,
    physical_device_id_properties = 1000071004,
    external_memory_buffer_create_info = 1000072000,
    external_memory_image_create_info = 1000072001,
    export_memory_allocate_info = 1000072002,
    physical_device_external_fence_info = 1000112000,
    external_fence_properties = 1000112001,
    export_fence_create_info = 1000113000,
    export_semaphore_create_info = 1000077000,
    physical_device_external_semaphore_info = 1000076000,
    external_semaphore_properties = 1000076001,
    physical_device_subgroup_properties = 1000094000,
    physical_device_16bit_storage_features = 1000083000,
    physical_device_variable_pointers_features = 1000120000,
    descriptor_update_template_create_info = 1000085000,
    physical_device_maintenance_3_properties = 1000168000,
    descriptor_set_layout_support = 1000168001,
    sampler_ycbcr_conversion_create_info = 1000156000,
    sampler_ycbcr_conversion_info = 1000156001,
    bind_image_plane_memory_info = 1000156002,
    image_plane_memory_requirements_info = 1000156003,
    physical_device_sampler_ycbcr_conversion_features = 1000156004,
    sampler_ycbcr_conversion_image_format_properties = 1000156005,
    device_group_render_pass_begin_info = 1000060003,
    physical_device_point_clipping_properties = 1000117000,
    render_pass_input_attachment_aspect_create_info = 1000117001,
    pipeline_tessellation_domain_origin_state_create_info = 1000117003,
    render_pass_multiview_create_info = 1000053000,
    physical_device_multiview_features = 1000053001,
    physical_device_multiview_properties = 1000053002,
    physical_device_shader_draw_parameters_features = 1000063000,
    physical_device_vulkan_1_1_features = 49,
    physical_device_vulkan_1_1_properties = 50,
    physical_device_vulkan_1_2_features = 51,
    physical_device_vulkan_1_2_properties = 52,
    image_format_list_create_info = 1000147000,
    physical_device_driver_properties = 1000196000,
    physical_device_vulkan_memory_model_features = 1000211000,
    physical_device_host_query_reset_features = 1000261000,
    physical_device_timeline_semaphore_features = 1000207000,
    physical_device_timeline_semaphore_properties = 1000207001,
    semaphore_type_create_info = 1000207002,
    timeline_semaphore_submit_info = 1000207003,
    semaphore_wait_info = 1000207004,
    semaphore_signal_info = 1000207005,
    physical_device_buffer_device_address_features = 1000257000,
    buffer_device_address_info = 1000244001,
    buffer_opaque_capture_address_create_info = 1000257002,
    memory_opaque_capture_address_allocate_info = 1000257003,
    device_memory_opaque_capture_address_info = 1000257004,
    physical_device_8bit_storage_features = 1000177000,
    physical_device_shader_atomic_int64_features = 1000180000,
    physical_device_shader_float16_int8_features = 1000082000,
    physical_device_float_controls_properties = 1000197000,
    descriptor_set_layout_binding_flags_create_info = 1000161000,
    physical_device_descriptor_indexing_features = 1000161001,
    physical_device_descriptor_indexing_properties = 1000161002,
    descriptor_set_variable_descriptor_count_allocate_info = 1000161003,
    descriptor_set_variable_descriptor_count_layout_support = 1000161004,
    physical_device_scalar_block_layout_features = 1000221000,
    physical_device_sampler_filter_minmax_properties = 1000130000,
    sampler_reduction_mode_create_info = 1000130001,
    physical_device_uniform_buffer_standard_layout_features = 1000253000,
    physical_device_shader_subgroup_extended_types_features = 1000175000,
    attachment_description_2 = 1000109000,
    attachment_reference_2 = 1000109001,
    subpass_description_2 = 1000109002,
    subpass_dependency_2 = 1000109003,
    render_pass_create_info_2 = 1000109004,
    subpass_begin_info = 1000109005,
    subpass_end_info = 1000109006,
    physical_device_depth_stencil_resolve_properties = 1000199000,
    subpass_description_depth_stencil_resolve = 1000199001,
    image_stencil_usage_create_info = 1000246000,
    physical_device_imageless_framebuffer_features = 1000108000,
    framebuffer_attachments_create_info = 1000108001,
    framebuffer_attachment_image_info = 1000108002,
    render_pass_attachment_begin_info = 1000108003,
    physical_device_separate_depth_stencil_layouts_features = 1000241000,
    attachment_reference_stencil_layout = 1000241001,
    attachment_description_stencil_layout = 1000241002,
    physical_device_vulkan_1_3_features = 53,
    physical_device_vulkan_1_3_properties = 54,
    physical_device_tool_properties = 1000245000,
    physical_device_private_data_features = 1000295000,
    device_private_data_create_info = 1000295001,
    private_data_slot_create_info = 1000295002,
    memory_barrier_2 = 1000314000,
    buffer_memory_barrier_2 = 1000314001,
    image_memory_barrier_2 = 1000314002,
    dependency_info = 1000314003,
    submit_info_2 = 1000314004,
    semaphore_submit_info = 1000314005,
    command_buffer_submit_info = 1000314006,
    physical_device_synchronization_2_features = 1000314007,
    copy_buffer_info_2 = 1000337000,
    copy_image_info_2 = 1000337001,
    copy_buffer_to_image_info_2 = 1000337002,
    copy_image_to_buffer_info_2 = 1000337003,
    buffer_copy_2 = 1000337006,
    image_copy_2 = 1000337007,
    buffer_image_copy_2 = 1000337009,
    physical_device_texture_compression_astc_hdr_features = 1000066000,
    format_properties_3 = 1000360000,
    physical_device_maintenance_4_features = 1000413000,
    physical_device_maintenance_4_properties = 1000413001,
    device_buffer_memory_requirements = 1000413002,
    device_image_memory_requirements = 1000413003,
    pipeline_creation_feedback_create_info = 1000192000,
    physical_device_shader_terminate_invocation_features = 1000215000,
    physical_device_shader_demote_to_helper_invocation_features = 1000276000,
    physical_device_pipeline_creation_cache_control_features = 1000297000,
    physical_device_zero_initialize_workgroup_memory_features = 1000325000,
    physical_device_image_robustness_features = 1000335000,
    physical_device_subgroup_size_control_properties = 1000225000,
    pipeline_shader_stage_required_subgroup_size_create_info = 1000225001,
    physical_device_subgroup_size_control_features = 1000225002,
    physical_device_inline_uniform_block_features = 1000138000,
    physical_device_inline_uniform_block_properties = 1000138001,
    write_descriptor_set_inline_uniform_block = 1000138002,
    descriptor_pool_inline_uniform_block_create_info = 1000138003,
    physical_device_shader_integer_dot_product_features = 1000280000,
    physical_device_shader_integer_dot_product_properties = 1000280001,
    physical_device_texel_buffer_alignment_properties = 1000281001,
    blit_image_info_2 = 1000337004,
    resolve_image_info_2 = 1000337005,
    image_blit_2 = 1000337008,
    image_resolve_2 = 1000337010,
    rendering_info = 1000044000,
    rendering_attachment_info = 1000044001,
    pipeline_rendering_create_info = 1000044002,
    physical_device_dynamic_rendering_features = 1000044003,
    command_buffer_inheritance_rendering_info = 1000044004,
    physical_device_vulkan_1_4_features = 55,
    physical_device_vulkan_1_4_properties = 56,
    device_queue_global_priority_create_info = 1000174000,
    physical_device_global_priority_query_features = 1000388000,
    queue_family_global_priority_properties = 1000388001,
    physical_device_index_type_uint8_features = 1000265000,
    memory_map_info = 1000271000,
    memory_unmap_info = 1000271001,
    physical_device_maintenance_5_features = 1000470000,
    physical_device_maintenance_5_properties = 1000470001,
    device_image_subresource_info = 1000470004,
    subresource_layout_2 = 1000338002,
    image_subresource_2 = 1000338003,
    buffer_usage_flags_2_create_info = 1000470006,
    physical_device_maintenance_6_features = 1000545000,
    physical_device_maintenance_6_properties = 1000545001,
    bind_memory_status = 1000545002,
    physical_device_host_image_copy_features = 1000270000,
    physical_device_host_image_copy_properties = 1000270001,
    memory_to_image_copy = 1000270002,
    image_to_memory_copy = 1000270003,
    copy_image_to_memory_info = 1000270004,
    copy_memory_to_image_info = 1000270005,
    host_image_layout_transition_info = 1000270006,
    copy_image_to_image_info = 1000270007,
    subresource_host_memcpy_size = 1000270008,
    host_image_copy_device_performance_query = 1000270009,
    physical_device_shader_subgroup_rotate_features = 1000416000,
    physical_device_shader_float_controls_2_features = 1000528000,
    physical_device_shader_expect_assume_features = 1000544000,
    pipeline_create_flags_2_create_info = 1000470005,
    physical_device_push_descriptor_properties = 1000080000,
    bind_descriptor_sets_info = 1000545003,
    push_constants_info = 1000545004,
    push_descriptor_set_info = 1000545005,
    push_descriptor_set_with_template_info = 1000545006,
    physical_device_pipeline_protected_access_features = 1000466000,
    pipeline_robustness_create_info = 1000068000,
    physical_device_pipeline_robustness_features = 1000068001,
    physical_device_pipeline_robustness_properties = 1000068002,
    physical_device_line_rasterization_features = 1000259000,
    pipeline_rasterization_line_state_create_info = 1000259001,
    physical_device_line_rasterization_properties = 1000259002,
    physical_device_vertex_attribute_divisor_properties = 1000525000,
    pipeline_vertex_input_divisor_state_create_info = 1000190001,
    physical_device_vertex_attribute_divisor_features = 1000190002,
    rendering_area_info = 1000470003,
    physical_device_dynamic_rendering_local_read_features = 1000232000,
    rendering_attachment_location_info = 1000232001,
    rendering_input_attachment_index_info = 1000232002,
    swapchain_create_info_khr = 1000001000,
    present_info_khr = 1000001001,
    device_group_present_capabilities_khr = 1000060007,
    image_swapchain_create_info_khr = 1000060008,
    bind_image_memory_swapchain_info_khr = 1000060009,
    acquire_next_image_info_khr = 1000060010,
    device_group_present_info_khr = 1000060011,
    device_group_swapchain_create_info_khr = 1000060012,
    display_mode_create_info_khr = 1000002000,
    display_surface_create_info_khr = 1000002001,
    display_present_info_khr = 1000003000,
    xlib_surface_create_info_khr = 1000004000,
    xcb_surface_create_info_khr = 1000005000,
    wayland_surface_create_info_khr = 1000006000,
    android_surface_create_info_khr = 1000008000,
    win32_surface_create_info_khr = 1000009000,
    debug_report_callback_create_info_ext = 1000011000,
    pipeline_rasterization_state_rasterization_order_amd = 1000018000,
    debug_marker_object_name_info_ext = 1000022000,
    debug_marker_object_tag_info_ext = 1000022001,
    debug_marker_marker_info_ext = 1000022002,
    video_profile_info_khr = 1000023000,
    video_capabilities_khr = 1000023001,
    video_picture_resource_info_khr = 1000023002,
    video_session_memory_requirements_khr = 1000023003,
    bind_video_session_memory_info_khr = 1000023004,
    video_session_create_info_khr = 1000023005,
    video_session_parameters_create_info_khr = 1000023006,
    video_session_parameters_update_info_khr = 1000023007,
    video_begin_coding_info_khr = 1000023008,
    video_end_coding_info_khr = 1000023009,
    video_coding_control_info_khr = 1000023010,
    video_reference_slot_info_khr = 1000023011,
    queue_family_video_properties_khr = 1000023012,
    video_profile_list_info_khr = 1000023013,
    physical_device_video_format_info_khr = 1000023014,
    video_format_properties_khr = 1000023015,
    queue_family_query_result_status_properties_khr = 1000023016,
    video_decode_info_khr = 1000024000,
    video_decode_capabilities_khr = 1000024001,
    video_decode_usage_info_khr = 1000024002,
    dedicated_allocation_image_create_info_nv = 1000026000,
    dedicated_allocation_buffer_create_info_nv = 1000026001,
    dedicated_allocation_memory_allocate_info_nv = 1000026002,
    physical_device_transform_feedback_features_ext = 1000028000,
    physical_device_transform_feedback_properties_ext = 1000028001,
    pipeline_rasterization_state_stream_create_info_ext = 1000028002,
    cu_module_create_info_nvx = 1000029000,
    cu_function_create_info_nvx = 1000029001,
    cu_launch_info_nvx = 1000029002,
    cu_module_texturing_mode_create_info_nvx = 1000029004,
    image_view_handle_info_nvx = 1000030000,
    image_view_address_properties_nvx = 1000030001,
    video_encode_h264_capabilities_khr = 1000038000,
    video_encode_h264_session_parameters_create_info_khr = 1000038001,
    video_encode_h264_session_parameters_add_info_khr = 1000038002,
    video_encode_h264_picture_info_khr = 1000038003,
    video_encode_h264_dpb_slot_info_khr = 1000038004,
    video_encode_h264_nalu_slice_info_khr = 1000038005,
    video_encode_h264_gop_remaining_frame_info_khr = 1000038006,
    video_encode_h264_profile_info_khr = 1000038007,
    video_encode_h264_rate_control_info_khr = 1000038008,
    video_encode_h264_rate_control_layer_info_khr = 1000038009,
    video_encode_h264_session_create_info_khr = 1000038010,
    video_encode_h264_quality_level_properties_khr = 1000038011,
    video_encode_h264_session_parameters_get_info_khr = 1000038012,
    video_encode_h264_session_parameters_feedback_info_khr = 1000038013,
    video_encode_h265_capabilities_khr = 1000039000,
    video_encode_h265_session_parameters_create_info_khr = 1000039001,
    video_encode_h265_session_parameters_add_info_khr = 1000039002,
    video_encode_h265_picture_info_khr = 1000039003,
    video_encode_h265_dpb_slot_info_khr = 1000039004,
    video_encode_h265_nalu_slice_segment_info_khr = 1000039005,
    video_encode_h265_gop_remaining_frame_info_khr = 1000039006,
    video_encode_h265_profile_info_khr = 1000039007,
    video_encode_h265_rate_control_info_khr = 1000039009,
    video_encode_h265_rate_control_layer_info_khr = 1000039010,
    video_encode_h265_session_create_info_khr = 1000039011,
    video_encode_h265_quality_level_properties_khr = 1000039012,
    video_encode_h265_session_parameters_get_info_khr = 1000039013,
    video_encode_h265_session_parameters_feedback_info_khr = 1000039014,
    video_decode_h264_capabilities_khr = 1000040000,
    video_decode_h264_picture_info_khr = 1000040001,
    video_decode_h264_profile_info_khr = 1000040003,
    video_decode_h264_session_parameters_create_info_khr = 1000040004,
    video_decode_h264_session_parameters_add_info_khr = 1000040005,
    video_decode_h264_dpb_slot_info_khr = 1000040006,
    texture_lod_gather_format_properties_amd = 1000041000,
    stream_descriptor_surface_create_info_ggp = 1000049000,
    physical_device_corner_sampled_image_features_nv = 1000050000,
    external_memory_image_create_info_nv = 1000056000,
    export_memory_allocate_info_nv = 1000056001,
    import_memory_win32_handle_info_nv = 1000057000,
    export_memory_win32_handle_info_nv = 1000057001,
    win32_keyed_mutex_acquire_release_info_nv = 1000058000,
    validation_flags_ext = 1000061000,
    vi_surface_create_info_nn = 1000062000,
    image_view_astc_decode_mode_ext = 1000067000,
    physical_device_astc_decode_features_ext = 1000067001,
    import_memory_win32_handle_info_khr = 1000073000,
    export_memory_win32_handle_info_khr = 1000073001,
    memory_win32_handle_properties_khr = 1000073002,
    memory_get_win32_handle_info_khr = 1000073003,
    import_memory_fd_info_khr = 1000074000,
    memory_fd_properties_khr = 1000074001,
    memory_get_fd_info_khr = 1000074002,
    win32_keyed_mutex_acquire_release_info_khr = 1000075000,
    import_semaphore_win32_handle_info_khr = 1000078000,
    export_semaphore_win32_handle_info_khr = 1000078001,
    d3d12_fence_submit_info_khr = 1000078002,
    semaphore_get_win32_handle_info_khr = 1000078003,
    import_semaphore_fd_info_khr = 1000079000,
    semaphore_get_fd_info_khr = 1000079001,
    command_buffer_inheritance_conditional_rendering_info_ext = 1000081000,
    physical_device_conditional_rendering_features_ext = 1000081001,
    conditional_rendering_begin_info_ext = 1000081002,
    present_regions_khr = 1000084000,
    pipeline_viewport_w_scaling_state_create_info_nv = 1000087000,
    surface_capabilities_2_ext = 1000090000,
    display_power_info_ext = 1000091000,
    device_event_info_ext = 1000091001,
    display_event_info_ext = 1000091002,
    swapchain_counter_create_info_ext = 1000091003,
    present_times_info_google = 1000092000,
    physical_device_multiview_per_view_attributes_properties_nvx = 1000097000,
    multiview_per_view_attributes_info_nvx = 1000044009,
    pipeline_viewport_swizzle_state_create_info_nv = 1000098000,
    physical_device_discard_rectangle_properties_ext = 1000099000,
    pipeline_discard_rectangle_state_create_info_ext = 1000099001,
    physical_device_conservative_rasterization_properties_ext = 1000101000,
    pipeline_rasterization_conservative_state_create_info_ext = 1000101001,
    physical_device_depth_clip_enable_features_ext = 1000102000,
    pipeline_rasterization_depth_clip_state_create_info_ext = 1000102001,
    hdr_metadata_ext = 1000105000,
    physical_device_relaxed_line_rasterization_features_img = 1000110000,
    shared_present_surface_capabilities_khr = 1000111000,
    import_fence_win32_handle_info_khr = 1000114000,
    export_fence_win32_handle_info_khr = 1000114001,
    fence_get_win32_handle_info_khr = 1000114002,
    import_fence_fd_info_khr = 1000115000,
    fence_get_fd_info_khr = 1000115001,
    physical_device_performance_query_features_khr = 1000116000,
    physical_device_performance_query_properties_khr = 1000116001,
    query_pool_performance_create_info_khr = 1000116002,
    performance_query_submit_info_khr = 1000116003,
    acquire_profiling_lock_info_khr = 1000116004,
    performance_counter_khr = 1000116005,
    performance_counter_description_khr = 1000116006,
    physical_device_surface_info_2_khr = 1000119000,
    surface_capabilities_2_khr = 1000119001,
    surface_format_2_khr = 1000119002,
    display_properties_2_khr = 1000121000,
    display_plane_properties_2_khr = 1000121001,
    display_mode_properties_2_khr = 1000121002,
    display_plane_info_2_khr = 1000121003,
    display_plane_capabilities_2_khr = 1000121004,
    ios_surface_create_info_mvk = 1000122000,
    macos_surface_create_info_mvk = 1000123000,
    debug_utils_object_name_info_ext = 1000128000,
    debug_utils_object_tag_info_ext = 1000128001,
    debug_utils_label_ext = 1000128002,
    debug_utils_messenger_callback_data_ext = 1000128003,
    debug_utils_messenger_create_info_ext = 1000128004,
    android_hardware_buffer_usage_android = 1000129000,
    android_hardware_buffer_properties_android = 1000129001,
    android_hardware_buffer_format_properties_android = 1000129002,
    import_android_hardware_buffer_info_android = 1000129003,
    memory_get_android_hardware_buffer_info_android = 1000129004,
    external_format_android = 1000129005,
    android_hardware_buffer_format_properties_2_android = 1000129006, // 642
};

const ObjectType = enum(c_uint) { // 1712
};

const SystemAllocationScope = enum(c_uint) {}; // 1793

const InternalAllocationType = enum(c_uint) {}; // 1802

const InstanceCreateFlags = Flags; // 2802

pub const AllocationFunction = ?*const fn ( // 3378
    user_data: ?*anyopaque,
    size: usize,
    alignment: usize,
    allocation_scope: SystemAllocationScope,
) callconv(.c) ?*anyopaque;

pub const FreeFunction = ?*const fn ( // 3384
    user_data: ?*anyopaque,
    memory: ?*anyopaque,
) callconv(.c) void;

pub const InternalAllocationNotification = ?*const fn ( // 3388
    user_data: ?*anyopaque,
    size: usize,
    allocation_type: InternalAllocationType,
    allocation_scope: SystemAllocationScope,
) callconv(.c) void;

pub const InternalFreeNotification = ?*const fn ( // 3394
    user_data: ?*anyopaque,
    size: usize,
    allocation_type: InternalAllocationType,
    allocation_scope: SystemAllocationScope,
) callconv(.c) void;

pub const ReallocationFunction = ?*const fn ( // 3400
    userData: ?*anyopaque,
    original: ?*anyopaque,
    size: usize,
    alignment: usize,
    allocation_scope: SystemAllocationScope,
) callconv(.c) ?*anyopaque;

pub const VoidFunction = ?*const fn () callconv(.c) void; // 3407

pub const AllocationCallbacks = extern struct { // 3408
    user_data: ?*anyopaque = null,
    allocation: AllocationFunction = null,
    reallocation: ReallocationFunction = null,
    free: FreeFunction = null,
    internal_allocation: InternalAllocationNotification = null,
    internal_free: InternalFreeNotification = null,
};

pub const ApplicationInfo = extern struct { // 3417
    type: StructureType = .application_info,
    next: ?*const anyopaque = null,
    application_name: [*:0]const u8,
    application_version: Version,
    engine_name: [*:0]const u8,
    engine_version: Version,
    api_version: ApiVersion,
};

pub const InstanceCreateInfo = extern struct { // 3441
    type: StructureType = .instance_create_info,
    next: ?*const anyopaque = null,
    flags: InstanceCreateFlags = 0,
    application_info: *const ApplicationInfo,
    enabled_layer_count: u32 = 0,
    enabled_layer_names: ?[*]const [*:0]const u8 = null,
    enabled_extension_count: u32 = 0,
    enabled_extension_names: ?[*]const [*:0]const u8 = null,
};

const ExtensionProperties = extern struct { // 3687
    extension_name: [max_extension_name_size]u8,
    spec_version: u32,
};

const LayerProperties = extern struct { // 3692
    layer_name: [max_extension_name_size]u8,
    spec_version: u32, // fix me
    implementation_version: u32, // fix me
    description: [max_extension_name_size]u8,
};

pub extern fn vkGetInstanceProcAddr(instance: Instance, name: [*:0]const u8) VoidFunction; // 4610

extern fn vkEnumerateInstanceExtensionProperties( // 4628
    layer_name: [*c]const u8,
    property_count: [*c]u32,
    properties: [*c]ExtensionProperties,
) Result;
pub const enumerateInstanceExtensionProperties = vkEnumerateInstanceExtensionProperties;

extern fn vkEnumerateInstanceLayerProperties( // 4639
    property_count: *u32,
    properties: ?[*]LayerProperties,
) Result;
pub fn enumerateInstanceLayerProperties(gpa: std.mem.Allocator) ![]LayerProperties {
    var property_count: u32 = undefined;
    assert(vkEnumerateInstanceLayerProperties(&property_count, null) == .success);
    var properties = try gpa.alloc(LayerProperties, property_count);
    assert(vkEnumerateInstanceLayerProperties(&property_count, properties.ptr) == .success);
    return properties[0..property_count];
}

const DebugUtilsMessengerEXTImpl = opaque {}; // 15364
pub const DebugUtilsMessengerEXT = ?*DebugUtilsMessengerEXTImpl;

pub const ext_debug_utils_extension_name = "VK_EXT_debug_utils"; // 15366

pub const DebugUtilsMessageSeverityFlagBitsEXT = enum(c_uint) { // 15369
    verbose = 0x00000001,
    info = 0x00000010,
    warning = 0x00000100,
    @"error" = 0x00001000,
};

pub const DebugUtilsMessengerCallbackDataFlagsEXT = Flags; // 15367
pub const DebugUtilsMessageTypeFlagsEXT = packed struct(Flags) { // 15384
    general: bool = false, // 1
    validation: bool = false, // 2
    performance: bool = false, // 4
    device_address_binding: bool = false, // 5
    _pad0: u28 = 0,
};
pub const DebugUtilsMessageSeverityFlagEXT = packed struct(Flags) { // 15385
    verbose: bool = false, // 1
    _pad0: u3 = 0, // 2,4,8
    info: bool = false, // 16
    _pad1: u3 = 0, // 32, 64, 128
    warning: bool = false, // 256
    _pad2: u3 = 0, // 512, 1024, 2048
    @"error": bool = false, // 4096
    _pad3: u19 = 0,
};

pub const DebugUtilsMessengerCreateFlagsEXT = Flags; // 15386

pub const DebugUtilsLabelEXT = extern struct { // 15387
    type: StructureType = .debug_utils_label_ext,
    pext: ?*const anyopaque = null,
    label_name: [*c]const u8,
    color: [4]f32,
};

pub const DebugUtilsObjectNameInfoEXT = extern struct { // 15394
    type: StructureType = .debug_utils_object_name_info_ext,
    next: ?*const anyopaque = null,
    object_type: ObjectType,
    object_handle: u64,
    object_name: [*c]const u8,
};

pub const DebugUtilsMessengerCallbackDataEXT = extern struct { // 15402
    type: StructureType = .debug_utils_messenger_callback_data_ext,
    next: ?*const anyopaque = null,
    flags: DebugUtilsMessengerCallbackDataFlagsEXT,
    message_id_name: [*c]const u8,
    message_id_number: i32,
    message: [*c]const u8,
    queue_label_count: u32,
    queue_labels: [*c]const DebugUtilsLabelEXT,
    cmd_buf_label_count: u32,
    cmd_buf_labels: [*c]const DebugUtilsLabelEXT,
    object_count: u32,
    objects: [*c]const DebugUtilsObjectNameInfoEXT,
};

const DebugUtilsMessengerCallbackEXT = ?*const fn ( //15417
    message_severity: DebugUtilsMessageSeverityFlagBitsEXT,
    message_types: DebugUtilsMessageTypeFlagsEXT,
    callback_data: *const DebugUtilsMessengerCallbackDataEXT,
    user_data: ?*anyopaque,
) callconv(.c) Bool32;

pub const DebugUtilsMessengerCreateInfoEXT = extern struct { // 15423
    type: StructureType = .debug_utils_messenger_create_info_ext,
    next: ?*const anyopaque = null,
    flags: DebugUtilsMessengerCreateFlagsEXT = 0,
    message_severity: DebugUtilsMessageSeverityFlagEXT = .{},
    message_type: DebugUtilsMessageTypeFlagsEXT = .{},
    user_callback: DebugUtilsMessengerCallbackEXT = null,
    user_data: ?*anyopaque = null,
};

const CreateDebugUtilsMessengerEXTFunction = ?*const fn ( // 15451
    instance: Instance,
    create_info: *const DebugUtilsMessengerCreateInfoEXT,
    allocator: ?*const AllocationCallbacks,
    messenger: *DebugUtilsMessengerEXT,
) callconv(.c) Result;

const DestroyDebugUtilsMessengerEXTFunction = ?*const fn ( // 15452
    instance: Instance,
    messenger: DebugUtilsMessengerEXT,
    allocator: ?*const AllocationCallbacks,
) callconv(.c) void;

pub fn CreateDebugUtilsMessengerEXT( // 15503
    instance: Instance,
    create_info: *const DebugUtilsMessengerCreateInfoEXT,
    allocator: ?*const AllocationCallbacks,
) !DebugUtilsMessengerEXT {
    const func: CreateDebugUtilsMessengerEXTFunction = @ptrCast(
        vkGetInstanceProcAddr(instance, "vkCreateDebugUtilsMessengerEXT"),
    );
    if (func) |f| {
        var messenger: DebugUtilsMessengerEXT = undefined;
        if (f(instance, create_info, allocator, &messenger) != .success) unreachable; // fix me
        return messenger;
    } else {
        return error.ExtensionNotPresent;
    }
}

pub fn DestroyDebugUtilsMessengerEXT( // 15511
    instance: Instance,
    messenger: DebugUtilsMessengerEXT,
    allocator: ?*const AllocationCallbacks,
) void {
    const func: DestroyDebugUtilsMessengerEXTFunction = @ptrCast(
        vkGetInstanceProcAddr(instance, "vkDestroyDebugUtilsMessengerEXT"),
    );
    if (func) |f| f(instance, messenger, allocator);
}
