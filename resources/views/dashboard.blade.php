// ...existing code...
?>
<x-app-layout>
    <x-slot name="header">
        <div class="flex items-center justify-between">
            <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
                ダッシュボード
            </h2>
            @if(optional(Auth::user())->role === 1)
                <a href="{{ route('admin.shifts.create') }}" class="inline-block px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
                    シフト作成
                </a>
            @endif
        </div>
    </x-slot>    
// ...existing code...
    @push('scripts')
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js'></script>

    <script>
        // Blade で事前に判定して JS に渡す（安全）
        const isAdmin = @json(optional(Auth::user())->role === 1);

        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                locale: 'ja',
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek'
                },
                events: {!! $events !!},
                selectable: true,
                eventClick: function(info) {
                    if (isAdmin) {
                        let shiftId = info.event.id;
                        window.location.href = `/admin/shifts/${shiftId}/edit`;
                    }
                }
            });
            calendar.render();
        });
    </script>
    @endpush
</x-app-layout>
// ...existing code...